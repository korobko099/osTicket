/**
 * @version v1.12
 * @signature 277de0a6c3fc7062214428e43989cf1e
 * @title Add task templates and groups
 */

ALTER TABLE `%TABLE_PREFIX%task`
  ADD `template_id` int(11) unsigned DEFAULT NULL AFTER `object_type`,
  ADD `set_id` int(11) unsigned DEFAULT NULL AFTER `template_id`,
  ADD `started` datetime DEFAULT NULL AFTER `duedate`,
  ADD KEY `set_id` (`set_id`);

ALTER TABLE `%TABLE_PREFIX%help_topic`
  ADD `task_group_id` int(10) unsigned NOT NULL DEFAULT '0' AFTER `sequence_id`;

INSERT INTO `%TABLE_PREFIX%event`
  (`id`, `name`)
  VALUES (15, 'started'), (16, 'cancelled');

DROP TABLE IF EXISTS `%TABLE_PREFIX%task_set`;
CREATE TABLE `%TABLE_PREFIX%task_set` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template_group_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `depends` int(10) unsigned NOT NULL DEFAULT '0',
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `completed` datetime NULL,
  PRIMARY KEY (`id`),
  KEY `depends` (`depends`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%TABLE_PREFIX%task_template`;
CREATE TABLE `%TABLE_PREFIX%task_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL,
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `duedate` varchar(20) collate ascii_bin DEFAULT NULL COMMENT 'eg. `ticket+2d`',
  `depends` text collate ascii_bin NULL,
  `data` TEXT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%TABLE_PREFIX%task_template_form`;
CREATE TABLE `%TABLE_PREFIX%task_template_form` (
  `template_id` int(10) unsigned NOT NULL,
  `form_id` int(10) unsigned NOT NULL,
  `sort` int(10) unsigned DEFAULT NULL,
  `data` text,
  `extra` text,
  PRIMARY KEY (`template_id`,`form_id`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%TABLE_PREFIX%task_template_group`;
CREATE TABLE `%TABLE_PREFIX%task_template_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;

-- Finished with patch
UPDATE `%TABLE_PREFIX%config`
    SET `value` = '859f0f41b2084fa443cd6caaf1ecc161'
    WHERE `key` = 'schema_signature' AND `namespace` = 'core';
