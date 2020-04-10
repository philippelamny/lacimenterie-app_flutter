import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AgencePaddingHeaderWidget extends Padding {
  @override
  AgencePaddingHeaderWidget(urlPhoto, agencyName, userName,  {Key key})
      : super(key: key, padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 5, 38, 5),
                  child: CachedNetworkImage(
                    height: 50,
                    fit: BoxFit.scaleDown,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: urlPhoto,
                  ),
                ),
                Expanded(
                  child: Column(
                    
                    children: <Widget>[
                      Text(agencyName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(userName,
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 1.0),
          ],
        ),);
  
}