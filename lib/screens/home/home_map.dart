import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/models/data/map_repository.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/screens/primary/widgets/filter_list.dart';
import 'package:vektor_if/screens/home/widgets/header_map.dart';
import 'package:vektor_if/screens/home/widgets/interactive_map.dart';

class HomeMap extends StatefulWidget {
  final String? institutionId;

  const HomeMap({super.key, this.institutionId});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  // --- DADOS ---
  String? _targetInstitutionId;
  String _targetInstitutionName = "Carregando...";
  String? _mapUrl;
  List<SectorModel> _allSectors = [];
  bool _isLoading = true;

  // --- FILTROS ---
  String _searchText = "";
  String _selectedFilter = "TODOS";

  final List<String> _filters = [
    "TODOS",
    "ADMINISTRATIVO",
    "TÉCNICO",
    "UTILIDADES",
  ];

  // --- REPOSITÓRIOS ---
  final _sectorsRepo = SectorsRepository();
  final _mapRepo = MapRepository();

  @override
  void initState() {
    super.initState();
    if (widget.institutionId != null) {
      _targetInstitutionId = widget.institutionId;
      _loadData();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_targetInstitutionId == null) {
      _resolveTargetInstitution();
    }
  }

  void _resolveTargetInstitution() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _targetInstitutionId = args['institutionId'];
      _targetInstitutionName = args['institutionName'] ?? "Instituição";
    } else {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _targetInstitutionId = user.uid;
        _targetInstitutionName = "Minha Instituição";
      }
    }

    if (_targetInstitutionId != null) {
      _loadData();
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadData() async {
    try {
      final url = await _mapRepo.getMapUrl(_targetInstitutionId!);

      _sectorsRepo.getSectorsStream(_targetInstitutionId!).listen((sectors) {
        if (mounted) {
          setState(() {
            _mapUrl = url;
            // Filtra setores 
            _allSectors = sectors
                .where((s) => s.mapX != null && s.mapY != null)
                .toList();
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<SectorModel> get _filteredSectors {
    return _allSectors.where((sector) {
      final matchesSearch =
          _searchText.isEmpty ||
          sector.name.toLowerCase().contains(_searchText.toLowerCase()) ||
          (sector.description ?? "").toLowerCase().contains(
            _searchText.toLowerCase(),
          );

      final matchesCategory =
          _selectedFilter == "TODOS" ||
          sector.category.toUpperCase() == _selectedFilter.toUpperCase();

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_targetInstitutionId == null && !_isLoading) {
      return const Scaffold(
        body: Center(child: Text("Nenhuma instituição selecionada.")),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      // evitar sobreposição na barra de status
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HomeHeader(
                    institutionName: _targetInstitutionName,
                    onSearchChanged: (val) => setState(() => _searchText = val),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: FilterList(
                      filters: _filters, 
                      selectedFilter: _selectedFilter,
                      onFilterSelected: (val) =>
                          setState(() => _selectedFilter = val),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: Text(
                      "Mapa Interativo",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.colorBlackText,
                            fontSize: 18,
                          ),
                    ),
                  ),
                  InteractiveMap(
                    height: context.percentHeight(0.45) < 300
                        ? 300
                        : context.percentHeight(0.45),
                    mapUrl: _mapUrl,
                    sectors: _filteredSectors,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}
