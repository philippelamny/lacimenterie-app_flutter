import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';

class CachedNetworkImageContractLacimenterie extends CachedNetworkImage {
 CachedNetworkImageContractLacimenterie(String url, {Key key, double width, BoxFit fit: BoxFit.scaleDown}) :
  super (
    key: key,
    placeholder: (context, url) => CachedNetworkImage(
      fit: fit,
      width: width,
      imageUrl: ContractApiLacimenterie.getDefaultImageContract(),
    ),
    fit: fit,
    width: width,
    imageUrl: ( url != null && url != "" ? url : ContractApiLacimenterie.getDefaultImageContract()),
  );
}