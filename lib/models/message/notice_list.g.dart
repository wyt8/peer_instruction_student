// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeList _$NoticeListFromJson(Map<String, dynamic> json) => NoticeList(
      notices: (json['notices'] as List<dynamic>)
          .map((e) => Notice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NoticeListToJson(NoticeList instance) =>
    <String, dynamic>{
      'notices': instance.notices,
    };
