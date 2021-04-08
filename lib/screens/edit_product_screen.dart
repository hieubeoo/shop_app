import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _editProduct = Product(
    id: null,
    title: '',
    description: '',
    imageUrl: '',
    price: 0.0,
  );
  var _initProduct = {
    'title': '',
    'price': '',
    'imageUrl': '',
    'description': ''
  };
  @override
  void initState() {
    _imageUrlFocusNode.addListener(updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _initProduct = {
          'title': _editProduct.title,
          'price': _editProduct.price.toString(),
          'description': _editProduct.description,
          'imageUrl': '',
        };
        _imageUrlControler.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionNode.dispose();
    _imageUrlControler.dispose();
    super.dispose();
  }

  void updateImage() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editProduct.id != null) {
      await Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProductItem(_editProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Đã xảy ra lỗi!'),
            content: Text('Some thing wrong :))'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(ctx).pop(), child: Text('Ok'))
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chỉnh sửa sản phẩm')),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ))
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          TextFormField(
                            initialValue: _initProduct['title'],
                            decoration: const InputDecoration(
                                labelText: 'Tên sản phẩm'),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            onSaved: (value) {
                              _editProduct = Product(
                                id: _editProduct.id,
                                description: _editProduct.description,
                                imageUrl: _editProduct.imageUrl,
                                price: _editProduct.price,
                                title: value,
                                isFavorite: _editProduct.isFavorite,
                              );
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Vui lòng nhập tên sản phẩm.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: _initProduct['price'],
                            decoration: const InputDecoration(labelText: 'Giá'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _priceFocusNode,
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_descriptionNode),
                            onSaved: (value) {
                              _editProduct = Product(
                                description: _editProduct.description,
                                id: _editProduct.id,
                                imageUrl: _editProduct.imageUrl,
                                price: double.parse(value),
                                title: _editProduct.title,
                                isFavorite: _editProduct.isFavorite,
                              );
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Vui lòng nhập giá sản phẩm.';
                              }
                              if (double.tryParse(value) <= 1000) {
                                return 'Giá sản phẩm phải lớn hơn 1000đ';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: _initProduct['description'],
                            decoration: InputDecoration(labelText: 'Mô tả'),
                            textInputAction: TextInputAction.next,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            focusNode: _descriptionNode,
                            onSaved: (value) {
                              _editProduct = Product(
                                description: value,
                                id: _editProduct.id,
                                imageUrl: _editProduct.imageUrl,
                                price: _editProduct.price,
                                title: _editProduct.title,
                                isFavorite: _editProduct.isFavorite,
                              );
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Vui lòng nhập mô tả sản phẩm.';
                              }
                              return null;
                            },
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.only(top: 10, right: 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: _imageUrlControler.text.isEmpty
                                    ? Text('Nhập Url ảnh')
                                    : FittedBox(
                                        child: Image.network(
                                            _imageUrlControler.text),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Đường dẫn Url',
                                  ),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageUrlControler,
                                  focusNode: _imageUrlFocusNode,
                                  onFieldSubmitted: (_) => _saveForm(),
                                  onSaved: (value) {
                                    _editProduct = Product(
                                      description: _editProduct.description,
                                      id: _editProduct.id,
                                      imageUrl: value,
                                      price: _editProduct.price,
                                      title: _editProduct.title,
                                      isFavorite: _editProduct.isFavorite,
                                    );
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Vui lòng nhập url hình ảnh sản phẩm.';
                                    }
                                    if (!value.startsWith('http') &&
                                        !value.startsWith('https')) {
                                      return 'Chuỗi bạn vừa nhập không phải là 1 url';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: _saveForm,
                      child: Text('Xác nhận'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
