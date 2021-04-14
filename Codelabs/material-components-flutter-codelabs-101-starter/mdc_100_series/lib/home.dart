// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:Shrine/model/products_repository.dart';
import 'package:Shrine/supplemental/asymmetric_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';

class HomePage extends StatelessWidget {
  final Category currentCategory;

  const HomePage({Key key, this.currentCategory: Category.all}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AsymmetricView(
        products: ProductsRepository.loadProducts(currentCategory));
  }


  List<Card> _generateCards(BuildContext context) {
    var products = ProductsRepository.loadProducts(Category.all);
    if (products == null || products.length == 0) {
      return const <Card>[];
    }

    var theme = Theme.of(context);
    final formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    var list = products
        .map((product) => Card(
              elevation: 0.0,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 18 / 11,
                    child: Image.asset(
                      product.assetName,
                      package: product.assetPackage,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product == null ? '' : product.name,
                          style: theme.textTheme.button,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          product == null
                              ? ''
                              : formatter.format(product.price),
                          style: theme.textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))
        .toList();
    return list;
  }
}
