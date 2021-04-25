import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelab/models/favorites.dart';
import 'package:testing_codelab/screens/favorites.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Sample'),
        actions: [
          TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, FavoritesPage.routeName);
              },
              icon: Icon(Icons.favorite_border),
              label: Text('Favorites'))
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 20,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => _ItemTile(index),
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  final int itemNo;

  const _ItemTile(this.itemNo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
          ),
          title: Text(
            'Item $itemNo',
            key: Key('text_$itemNo'),
          ),
          trailing: _FavoriteButton(
            itemNo: itemNo,
          )),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  final int itemNo;

  const _FavoriteButton({Key key, @required this.itemNo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context, listen: true);
    return IconButton(
        key: Key('icon_${widget.itemNo}'),
        icon: _buildIcon(),
        onPressed: () {
          var message = _manageItem(favoritesList.items);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            duration: Duration(seconds: 1),
          ));
        });
  }

  String _manageItem(List<int> favorites) {
    var containsItem = favorites.contains(widget.itemNo);
    if (containsItem) {
      favorites.remove(widget.itemNo);
      setState(() {
        isFavorite = false;
      });
      return 'Removed from favorites.';
    } else {
      favorites.add(widget.itemNo);
      setState(() {
        isFavorite = true;
      });
      return 'Added to favorites.';
    }
  }

  _buildIcon() {
    if (isFavorite) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }
}
