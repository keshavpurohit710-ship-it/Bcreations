import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/inventory_item.dart';
import 'inventory_provider.dart'; // Needed to fetch raw materials

class AddInventoryItemScreen extends ConsumerStatefulWidget {
  final InventoryItem? existingItem;
  const AddInventoryItemScreen({super.key, this.existingItem});

  @override
  ConsumerState<AddInventoryItemScreen> createState() =>
      _AddInventoryItemScreenState();
}

class _AddInventoryItemScreenState
    extends ConsumerState<AddInventoryItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _categoryController = TextEditingController();
  final _minStockController = TextEditingController(text: '5');
  final _costPriceController = TextEditingController(text: '0.0');

  String _selectedItemType = 'RawMaterial';
  String _selectedUnit = 'pcs';
  bool _isLoading = false;
  String? _imagePath;

  // --- THE FIX: State for the dynamic Recipe builder ---
  List<RecipeComponent> _recipe = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingItem != null) {
      _nameController.text = widget.existingItem!.name ?? '';
      _skuController.text = widget.existingItem!.sku ?? '';
      _categoryController.text = widget.existingItem!.category ?? '';
      _minStockController.text = widget.existingItem!.minStockLevel.toString();
      _costPriceController.text = widget.existingItem!.costPrice.toString();
      _selectedItemType = widget.existingItem!.itemType ?? 'RawMaterial';
      _selectedUnit = widget.existingItem!.unit ?? 'pcs';
      _imagePath = widget.existingItem!.imagePath;

      // Deep copy the recipe to avoid unintended database mutations before hitting "Save"
      if (widget.existingItem!.recipe != null) {
        _recipe = widget.existingItem!.recipe!
            .map((r) => RecipeComponent()
              ..rawMaterialId = r.rawMaterialId
              ..quantity = r.quantity)
            .toList();
      }
    } else {
      // --- THE FIX: Auto-Generate Sequential SKU on Load ---
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final service = ref.read(inventoryServiceProvider);
        final nextSku = await service.generateNextSku();
        if (mounted) {
          setState(() {
            _skuController.text = nextSku;
          });
        }
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile =
          await picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text('Choose from Gallery',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text('Take a Photo',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            if (_imagePath != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.redAccent),
                title: const Text('Remove Image',
                    style: TextStyle(color: Colors.redAccent)),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() => _imagePath = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final inventoryService = ref.read(inventoryServiceProvider);

      // --- THE FIX: Sanitize and Validate Recipe ---
      final validRecipe = _selectedItemType == 'FinishedGood'
          ? _recipe
              .where((r) =>
                  r.rawMaterialId != null &&
                  r.quantity != null &&
                  r.quantity! > 0)
              .toList()
          : null;

      // Hard check: Ensure Finished Goods actually have a formula specified
      if (_selectedItemType == 'FinishedGood' &&
          (validRecipe == null || validRecipe.isEmpty)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Finished Goods require at least one raw material in their recipe.'),
            backgroundColor: Colors.orangeAccent,
          ));
        }
        setState(() => _isLoading = false);
        return;
      }

      if (widget.existingItem != null) {
        final item = widget.existingItem!;
        item.name = _nameController.text.trim();
        item.sku = _skuController.text.trim().toUpperCase();
        item.category = _categoryController.text.trim();
        item.unit = _selectedUnit;
        item.itemType = _selectedItemType;
        item.minStockLevel = int.tryParse(_minStockController.text) ?? 5;
        item.costPrice = double.tryParse(_costPriceController.text) ?? 0.0;
        item.imagePath = _imagePath;
        item.recipe = validRecipe; // Attach the formatted recipe

        await inventoryService.updateItem(item);
      } else {
        await inventoryService.addItem(
          name: _nameController.text.trim(),
          sku: _skuController.text.trim(),
          category: _categoryController.text.trim().isEmpty
              ? 'General'
              : _categoryController.text.trim(),
          unit: _selectedUnit,
          itemType: _selectedItemType,
          minStockLevel: int.tryParse(_minStockController.text) ?? 5,
          costPrice: double.tryParse(_costPriceController.text) ?? 0.0,
          imagePath: _imagePath,
          recipe: validRecipe, // Attach the formatted recipe
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item saved successfully!'),
            backgroundColor: Colors.green));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _categoryController.dispose();
    _minStockController.dispose();
    _costPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fetch live inventory to populate the Raw Materials dropdown
    final inventoryAsync = ref.watch(inventoryItemsProvider);
    final rawMaterials = inventoryAsync.value
            ?.where((i) => i.itemType == 'RawMaterial')
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.existingItem != null ? 'Edit Item' : 'Register New Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _showImagePickerOptions,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.surfaceDark,
                        backgroundImage: _imagePath != null
                            ? FileImage(File(_imagePath!))
                            : null,
                        child: _imagePath == null
                            ? const Icon(Icons.inventory,
                                size: 40, color: Colors.grey)
                            : null,
                      ),
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.camera_alt,
                            size: 18, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedItemType,
                      dropdownColor: AppTheme.surfaceDark,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'Item Type',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                      items: ['RawMaterial', 'FinishedGood']
                          .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedItemType = val!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _skuController,
                      style: const TextStyle(color: Colors.white),
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                          labelText: 'SKU Code',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ==========================================
              // THE FIX: DYNAMIC BILL OF MATERIALS BUILDER
              // ==========================================
              if (_selectedItemType == 'FinishedGood') ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Colors.orangeAccent.withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Production Recipe (BOM)',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text(
                          'Define the raw materials required to assemble 1 unit of this finished good.',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 16),
                      if (_recipe.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: Text('No materials added yet.',
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ..._recipe.asMap().entries.map((entry) {
                        final index = entry.key;
                        final component = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<int>(
                                  value: component.rawMaterialId,
                                  dropdownColor: AppTheme.backgroundDark,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      labelText: 'Raw Material',
                                      labelStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent))),
                                  items: rawMaterials
                                      .map((rm) => DropdownMenuItem(
                                          value: rm.id,
                                          child: Text(rm.name ?? 'Unknown')))
                                      .toList(),
                                  onChanged: (val) => setState(
                                      () => component.rawMaterialId = val),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  initialValue:
                                      component.quantity?.toString() ?? '',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      labelText: 'Qty Required',
                                      labelStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent))),
                                  onChanged: (val) =>
                                      component.quantity = double.tryParse(val),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    color: Colors.redAccent),
                                onPressed: () =>
                                    setState(() => _recipe.removeAt(index)),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                      TextButton.icon(
                        icon: const Icon(Icons.add, color: Colors.orangeAccent),
                        label: const Text('Add Material to Recipe',
                            style: TextStyle(color: Colors.orangeAccent)),
                        onPressed: () =>
                            setState(() => _recipe.add(RecipeComponent())),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // ==========================================

              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _categoryController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'Sub-Category (e.g. Wood, Metal)',
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      dropdownColor: AppTheme.surfaceDark,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'Unit',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                      items: ['pcs', 'kg', 'm', 'L', 'box']
                          .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedUnit = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Supply Chain Settings',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const Divider(color: Colors.grey),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _minStockController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'Low Stock Alert Threshold',
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.orangeAccent))),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _costPriceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'Standard Cost (₹)',
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.greenAccent))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white),
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        widget.existingItem != null
                            ? 'Save Changes'
                            : 'Register Item',
                        style: const TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
