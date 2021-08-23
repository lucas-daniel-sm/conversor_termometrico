import 'package:conversor_termometrico/models/scale.dart';
import 'package:flutter/material.dart';

import 'widgets/scale_editor.dart';

class ManageScales extends StatefulWidget {
  final List<Scale> scaleList;

  const ManageScales({Key? key, required this.scaleList}) : super(key: key);

  @override
  _ManageScalesState createState() => _ManageScalesState();
}

class _ManageScalesState extends State<ManageScales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar escalas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, widget.scaleList),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.scaleList.length,
        itemBuilder: (c, i) {
          return ScaleListTile(
            item: widget.scaleList[i],
            deleteItem: (i) => setState(() => widget.scaleList.remove(i)),
            updateItem: (_, newValue) => setState(() {
              widget.scaleList.replaceRange(i, i + 1, [newValue]);
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar escala',
        onPressed: () => showDialog(
          context: context,
          builder: (_) => ScaleEditor(),
        ).then((value) {
          if (value != null) setState(() => widget.scaleList.add(value));
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}

class ScaleListTile extends StatefulWidget {
  final Scale item;
  final Function(Scale) deleteItem;
  final Function(Scale oldValue, Scale newValue) updateItem;

  const ScaleListTile({
    Key? key,
    required this.item,
    required this.deleteItem,
    required this.updateItem,
  }) : super(key: key);

  @override
  _ScaleListTileState createState() => _ScaleListTileState();
}

class _ScaleListTileState extends State<ScaleListTile> {
  @override
  Widget build(BuildContext context) {
    final String symbol =
        (widget.item.degree ? 'º' : '') + widget.item.name.characters.first;
    final String title = '${widget.item.name} ($symbol)';
    final String subtitle =
        'fusão da água: ${widget.item.melting}, ebulição: ${widget.item.boiling}';

    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(
        Icons.thermostat,
        color: Theme.of(context).accentColor,
      ),
      onLongPress: () => widget.deleteItem(widget.item),
      onTap: updateItem,
    );
  }

  void updateItem() {
    showDialog(
      context: context,
      builder: (_) {
        return ScaleEditor(value: widget.item);
      },
    ).then((value) {
      if (value == null) return;
      widget.updateItem(widget.item, value);
    });
  }
}
