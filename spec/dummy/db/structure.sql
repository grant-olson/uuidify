CREATE TABLE `bars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `foos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `uuidify_uuids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_id` int(11) DEFAULT NULL,
  `model_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_uuidify_uuids_on_model_name_and_model_id` (`model_name`,`model_id`),
  UNIQUE KEY `index_uuidify_uuids_on_model_uuid` (`model_uuid`),
  UNIQUE KEY `index_uuidify_uuids_on_model_uuid_and_model_id` (`model_uuid`,`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20130612135708');

INSERT INTO schema_migrations (version) VALUES ('20130612143347');

INSERT INTO schema_migrations (version) VALUES ('20130613135222');