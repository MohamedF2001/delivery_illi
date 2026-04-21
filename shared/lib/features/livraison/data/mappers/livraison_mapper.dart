import 'package:shared/core/models/livraison_model.dart';
import 'package:shared/features/livraison/domain/entities/livraison_entity.dart';
extension LivraisonModelMapper on LivraisonModel { LivraisonEntity toEntity() => this; }
