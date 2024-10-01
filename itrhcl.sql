-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2024 at 09:39 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `itrhcl`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `account_number` varchar(191) NOT NULL,
  `account_details` text DEFAULT NULL,
  `account_type_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_transactions`
--

CREATE TABLE `account_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `type` enum('debit','credit') NOT NULL,
  `sub_type` enum('opening_balance','fund_transfer','deposit') DEFAULT NULL,
  `amount` decimal(22,4) NOT NULL,
  `reff_no` varchar(191) DEFAULT NULL,
  `operation_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `transaction_payment_id` int(11) DEFAULT NULL,
  `transfer_transaction_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_types`
--

CREATE TABLE `account_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `parent_account_type_id` int(11) DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `log_name` varchar(191) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `subject_type` varchar(191) DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `causer_id` int(11) DEFAULT NULL,
  `causer_type` varchar(191) DEFAULT NULL,
  `properties` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_id`, `subject_type`, `business_id`, `causer_id`, `causer_type`, `properties`, `created_at`, `updated_at`) VALUES
(1, 'default', 'login', 1, 'App\\User', 1, 1, 'App\\User', '[]', '2024-08-25 23:51:46', '2024-08-25 23:51:46'),
(2, 'default', 'login', 1, 'App\\User', 1, 1, 'App\\User', '[]', '2024-08-26 09:50:23', '2024-08-26 09:50:23');

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(191) NOT NULL DEFAULT 'user',
  `surname` char(10) DEFAULT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `username` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `language` char(7) NOT NULL DEFAULT 'en',
  `contact_no` char(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `business_id` int(10) UNSIGNED DEFAULT NULL,
  `available_at` datetime DEFAULT NULL COMMENT 'Service staff avilable at. Calculated from product preparation_time_in_minutes',
  `paused_at` datetime DEFAULT NULL COMMENT 'Service staff available time paused at, Will be nulled on resume.',
  `max_sales_discount_percent` decimal(5,2) DEFAULT NULL,
  `allow_login` tinyint(1) NOT NULL DEFAULT 1,
  `status` enum('active','inactive','terminated') NOT NULL DEFAULT 'active',
  `crm_contact_id` int(10) UNSIGNED DEFAULT NULL,
  `is_cmmsn_agnt` tinyint(1) NOT NULL DEFAULT 0,
  `cmmsn_percent` decimal(4,2) NOT NULL DEFAULT 0.00,
  `selected_contacts` tinyint(1) NOT NULL DEFAULT 0,
  `dob` date DEFAULT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `marital_status` enum('married','unmarried','divorced') DEFAULT NULL,
  `blood_group` char(10) DEFAULT NULL,
  `contact_number` char(20) DEFAULT NULL,
  `alt_number` varchar(191) DEFAULT NULL,
  `family_number` varchar(191) DEFAULT NULL,
  `fb_link` varchar(191) DEFAULT NULL,
  `twitter_link` varchar(191) DEFAULT NULL,
  `social_media_1` varchar(191) DEFAULT NULL,
  `social_media_2` varchar(191) DEFAULT NULL,
  `permanent_address` text DEFAULT NULL,
  `current_address` text DEFAULT NULL,
  `guardian_name` varchar(191) DEFAULT NULL,
  `custom_field_1` varchar(191) DEFAULT NULL,
  `custom_field_2` varchar(191) DEFAULT NULL,
  `custom_field_3` varchar(191) DEFAULT NULL,
  `custom_field_4` varchar(191) DEFAULT NULL,
  `bank_details` longtext DEFAULT NULL,
  `id_proof_name` varchar(191) DEFAULT NULL,
  `id_proof_number` varchar(191) DEFAULT NULL,
  `admin_id` varchar(255) NOT NULL DEFAULT 'admin-0001',
  `photo` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `user_type`, `surname`, `first_name`, `last_name`, `username`, `email`, `password`, `language`, `contact_no`, `address`, `remember_token`, `business_id`, `available_at`, `paused_at`, `max_sales_discount_percent`, `allow_login`, `status`, `crm_contact_id`, `is_cmmsn_agnt`, `cmmsn_percent`, `selected_contacts`, `dob`, `gender`, `marital_status`, `blood_group`, `contact_number`, `alt_number`, `family_number`, `fb_link`, `twitter_link`, `social_media_1`, `social_media_2`, `permanent_address`, `current_address`, `guardian_name`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `bank_details`, `id_proof_name`, `id_proof_number`, `admin_id`, `photo`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'user', 'MR', 'SUPER', 'ADMIN', 'admin', 'admin@gmail.com', '$2y$12$HhBDIfLesSdhoD1X.gqTaOoIMwfhz.USEurCiwRDbyKmGQ2Nswm9.', 'en', NULL, NULL, NULL, 1, NULL, NULL, NULL, 1, 'active', NULL, 0, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', '1714192177.jpg', NULL, '2023-02-23 22:00:02', '2024-04-28 11:34:31');

-- --------------------------------------------------------

--
-- Table structure for table `balance_sheets`
--

CREATE TABLE `balance_sheets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(255) NOT NULL DEFAULT 'user',
  `amount` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `balance_sheets`
--

INSERT INTO `balance_sheets` (`id`, `user_id`, `user_type`, `amount`, `created_at`, `updated_at`) VALUES
(2, 117, 'user', 102.5, NULL, NULL),
(3, 111, 'user', 4.5, NULL, NULL),
(4, 116, 'user', 0.1, NULL, NULL),
(5, 118, 'user', 10, NULL, NULL),
(6, 121, 'user', 93, NULL, '2024-09-09 10:20:43'),
(7, 1, 'stockiest', 200, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `balance_transactions`
--

CREATE TABLE `balance_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `transaction_type` varchar(20) NOT NULL,
  `transaction_from` varchar(255) NOT NULL,
  `amount` varchar(255) NOT NULL,
  `gateway` enum('bkash','nagad','rocket','dbbl','0') DEFAULT NULL,
  `requested_to` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `business_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `business_id`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20', 4.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.1250, 0.0000, 0.1875, 2, 0, 0, 20, NULL, '2017-12-18 11:13:44', '2017-12-18 11:13:44'),
(2, '30 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30', 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.1880, 0.0000, 0.1250, 3, 0, 0, 30, NULL, '2017-12-18 11:04:39', '2017-12-18 11:10:40'),
(3, '32 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32', 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, '2017-12-18 10:55:40', '2017-12-18 10:55:40'),
(4, '40 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40', 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, '2017-12-18 10:58:40', '2017-12-18 10:58:40'),
(5, '50 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50', 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, '2017-12-18 10:51:10', '2017-12-18 10:51:10'),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm, Gap: 3.18mm', 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, '2017-12-18 10:51:10', '2017-12-18 10:51:10');

-- --------------------------------------------------------

--
-- Table structure for table `bonuses`
--

CREATE TABLE `bonuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contact_id` int(11) NOT NULL,
  `current_balance` double NOT NULL DEFAULT 0,
  `purchase_bonus` double NOT NULL DEFAULT 0,
  `creating_bonus` double NOT NULL DEFAULT 0,
  `re_creating_bonus` double NOT NULL DEFAULT 0,
  `rank_reward_bonus` double NOT NULL DEFAULT 0,
  `captainship_bonus` double NOT NULL DEFAULT 0,
  `guardianship_bonus` double NOT NULL DEFAULT 0,
  `after_death_allowance` double NOT NULL DEFAULT 0,
  `company_profit_share` double NOT NULL DEFAULT 0,
  `equal_bonus` double NOT NULL DEFAULT 0,
  `stokis_ref_bonus` double NOT NULL DEFAULT 0,
  `total_bonus` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bonus_info`
--

CREATE TABLE `bonus_info` (
  `id` bigint(20) NOT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `bonus_value` varchar(20) DEFAULT NULL,
  `bonus_name` varchar(255) DEFAULT NULL,
  `bonus_type` varchar(255) DEFAULT NULL,
  `percent` varchar(20) DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `paid` varchar(255) DEFAULT NULL,
  `getting_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bonus_reports`
--

CREATE TABLE `bonus_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `purchase_bonus` double NOT NULL DEFAULT 0,
  `creating_bonus` double NOT NULL DEFAULT 0,
  `re_creating_bonus` double NOT NULL DEFAULT 0,
  `equal_bonus` double NOT NULL DEFAULT 0,
  `stokis_ref_bonus` double NOT NULL DEFAULT 0,
  `total_bonus` double NOT NULL DEFAULT 0,
  `percent` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `contact_id` int(10) UNSIGNED NOT NULL,
  `waiter_id` int(10) UNSIGNED DEFAULT NULL,
  `table_id` int(10) UNSIGNED DEFAULT NULL,
  `correspondent_id` int(11) DEFAULT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `booking_start` datetime NOT NULL,
  `booking_end` datetime NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `booking_status` varchar(191) NOT NULL,
  `booking_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `business_id`, `name`, `description`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 1, 'ড্রিম কনজুমার ফুড প্রোডাক্ট', NULL, 1, NULL, '2023-08-28 15:12:37', '2023-08-28 15:12:37'),
(4, 1, 'Eegon', NULL, 1, NULL, '2023-08-28 15:12:42', '2024-07-14 10:32:47'),
(5, 1, 'Pran Company', 'Pran', 1, NULL, '2023-08-29 05:32:08', '2023-08-29 05:32:08'),
(6, 1, 'Mollah', 'Mollah', 1, NULL, '2023-08-29 05:46:59', '2023-08-29 05:46:59'),
(7, 1, 'Square', 'Square', 1, NULL, '2023-08-29 05:59:05', '2023-08-29 05:59:05'),
(8, 1, 'Aci', 'Aci', 1, NULL, '2023-08-29 06:19:17', '2023-08-29 06:19:17'),
(9, 1, 'Thia', 'Thia', 1, NULL, '2023-08-29 06:25:05', '2023-08-29 06:25:05'),
(10, 1, 'SMC', 'SMC', 1, NULL, '2023-08-29 06:28:40', '2023-08-29 06:28:40'),
(11, 1, 'Active', 'Active', 1, NULL, '2023-08-29 06:33:49', '2023-08-29 06:33:49'),
(12, 1, 'Rekit', 'Rekit', 1, NULL, '2023-08-29 06:37:05', '2023-08-29 06:37:05'),
(13, 1, 'Safiya', 'Safiya', 1, NULL, '2023-08-29 06:48:46', '2023-08-29 06:48:46'),
(14, 1, 'Teer', 'Teer', 1, NULL, '2023-08-29 06:58:22', '2023-08-29 06:58:22'),
(15, 1, 'DADA', 'DADA', 1, NULL, '2023-08-29 07:20:59', '2023-08-29 07:20:59'),
(16, 1, 'Palki', 'Palki', 1, NULL, '2023-08-29 07:30:19', '2023-08-29 07:30:19'),
(17, 1, 'Rupchanda', 'Rupchanda', 1, NULL, '2023-08-29 07:32:11', '2023-08-29 07:32:11'),
(18, 1, 'Bidi', 'Bidi', 1, NULL, '2023-08-29 07:34:35', '2023-08-29 07:34:35'),
(19, 1, 'Diamond', 'Diamond', 1, NULL, '2023-08-29 07:36:11', '2023-08-29 07:36:11'),
(20, 1, 'Horin', 'Horin', 1, NULL, '2023-08-29 07:37:40', '2023-08-29 07:37:40'),
(21, 1, 'Golden', 'Golden', 1, NULL, '2023-08-29 07:39:16', '2023-08-29 07:39:16'),
(22, 1, 'Petal', 'Petal', 1, NULL, '2023-08-29 11:28:32', '2023-08-29 11:28:32'),
(23, 1, 'Bashundhara', 'Bashundhara', 1, NULL, '2023-08-29 11:44:12', '2023-08-29 11:44:12'),
(24, 1, 'Omega', 'Omega', 1, NULL, '2023-08-29 11:56:16', '2023-08-29 11:56:16'),
(25, 1, 'AGC', 'AGC', 1, NULL, '2023-08-29 16:25:50', '2023-08-29 16:25:50'),
(26, 1, 'Dream Consumer Food Product', 'Kaf', 1, NULL, '2023-08-30 05:58:41', '2023-08-30 05:58:41'),
(27, 1, 'Sayed Super', 'SAYEED SUPER', 1, NULL, '2023-12-16 19:15:36', '2023-12-16 19:15:36'),
(28, 1, 'SAYEED SUPER', NULL, 1, NULL, '2024-01-22 02:49:25', '2024-01-22 02:49:25'),
(29, 1, 'Eegon Pharmaceuuticals (Ayu.)', NULL, 1, NULL, '2024-07-14 10:39:02', '2024-07-14 10:39:02'),
(32, 1, 'Ergon', NULL, 1, NULL, '2024-07-15 20:53:07', '2024-07-15 20:53:07');

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `tax_number_1` varchar(100) DEFAULT NULL,
  `tax_label_1` varchar(10) DEFAULT NULL,
  `tax_number_2` varchar(100) DEFAULT NULL,
  `tax_label_2` varchar(10) DEFAULT NULL,
  `code_label_1` varchar(191) DEFAULT NULL,
  `code_1` varchar(191) DEFAULT NULL,
  `code_label_2` varchar(191) DEFAULT NULL,
  `code_2` varchar(191) DEFAULT NULL,
  `default_sales_tax` int(10) UNSIGNED DEFAULT NULL,
  `default_profit_percent` double(5,2) NOT NULL DEFAULT 0.00,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `time_zone` varchar(191) NOT NULL DEFAULT 'Asia/Kolkata',
  `fy_start_month` tinyint(4) NOT NULL DEFAULT 1,
  `accounting_method` enum('fifo','lifo','avco') NOT NULL DEFAULT 'fifo',
  `default_sales_discount` decimal(5,2) DEFAULT NULL,
  `sell_price_tax` enum('includes','excludes') NOT NULL DEFAULT 'includes',
  `logo` varchar(191) DEFAULT NULL,
  `sku_prefix` varchar(191) DEFAULT NULL,
  `enable_product_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `expiry_type` enum('add_expiry','add_manufacturing') NOT NULL DEFAULT 'add_expiry',
  `on_product_expiry` enum('keep_selling','stop_selling','auto_delete') NOT NULL DEFAULT 'keep_selling',
  `stop_selling_before` int(11) NOT NULL COMMENT 'Stop selling expied item n days before expiry',
  `enable_tooltip` tinyint(1) NOT NULL DEFAULT 1,
  `purchase_in_diff_currency` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Allow purchase to be in different currency then the business currency',
  `purchase_currency_id` int(10) UNSIGNED DEFAULT NULL,
  `p_exchange_rate` decimal(20,3) NOT NULL DEFAULT 1.000,
  `transaction_edit_days` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `stock_expiry_alert_days` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `keyboard_shortcuts` text DEFAULT NULL,
  `pos_settings` text DEFAULT NULL,
  `weighing_scale_setting` text NOT NULL COMMENT 'used to store the configuration of weighing scale',
  `enable_brand` tinyint(1) NOT NULL DEFAULT 1,
  `enable_category` tinyint(1) NOT NULL DEFAULT 1,
  `enable_sub_category` tinyint(1) NOT NULL DEFAULT 1,
  `enable_price_tax` tinyint(1) NOT NULL DEFAULT 1,
  `enable_purchase_status` tinyint(1) DEFAULT 1,
  `enable_lot_number` tinyint(1) NOT NULL DEFAULT 0,
  `default_unit` int(11) DEFAULT NULL,
  `enable_sub_units` tinyint(1) NOT NULL DEFAULT 0,
  `enable_racks` tinyint(1) NOT NULL DEFAULT 0,
  `enable_row` tinyint(1) NOT NULL DEFAULT 0,
  `enable_position` tinyint(1) NOT NULL DEFAULT 0,
  `enable_editing_product_from_purchase` tinyint(1) NOT NULL DEFAULT 1,
  `sales_cmsn_agnt` enum('logged_in_user','user','cmsn_agnt') DEFAULT NULL,
  `item_addition_method` tinyint(1) NOT NULL DEFAULT 1,
  `enable_inline_tax` tinyint(1) NOT NULL DEFAULT 1,
  `currency_symbol_placement` enum('before','after') NOT NULL DEFAULT 'before',
  `enabled_modules` text DEFAULT NULL,
  `date_format` varchar(191) NOT NULL DEFAULT 'm/d/Y',
  `time_format` enum('12','24') NOT NULL DEFAULT '24',
  `currency_precision` tinyint(4) NOT NULL DEFAULT 2,
  `quantity_precision` tinyint(4) NOT NULL DEFAULT 2,
  `ref_no_prefixes` text DEFAULT NULL,
  `theme_color` char(20) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `enable_rp` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `rp_name` varchar(191) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `amount_for_unit_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_order_total_for_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `max_rp_per_order` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `pv_limit` int(11) NOT NULL DEFAULT 0,
  `redeem_amount_per_unit_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_order_total_for_redeem` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_redeem_point` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `max_redeem_point` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_period` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_type` enum('month','year') NOT NULL DEFAULT 'year' COMMENT 'rp is the short form of reward points',
  `email_settings` text DEFAULT NULL,
  `sms_settings` text DEFAULT NULL,
  `custom_labels` text DEFAULT NULL,
  `common_settings` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`id`, `name`, `currency_id`, `start_date`, `tax_number_1`, `tax_label_1`, `tax_number_2`, `tax_label_2`, `code_label_1`, `code_1`, `code_label_2`, `code_2`, `default_sales_tax`, `default_profit_percent`, `owner_id`, `time_zone`, `fy_start_month`, `accounting_method`, `default_sales_discount`, `sell_price_tax`, `logo`, `sku_prefix`, `enable_product_expiry`, `expiry_type`, `on_product_expiry`, `stop_selling_before`, `enable_tooltip`, `purchase_in_diff_currency`, `purchase_currency_id`, `p_exchange_rate`, `transaction_edit_days`, `stock_expiry_alert_days`, `keyboard_shortcuts`, `pos_settings`, `weighing_scale_setting`, `enable_brand`, `enable_category`, `enable_sub_category`, `enable_price_tax`, `enable_purchase_status`, `enable_lot_number`, `default_unit`, `enable_sub_units`, `enable_racks`, `enable_row`, `enable_position`, `enable_editing_product_from_purchase`, `sales_cmsn_agnt`, `item_addition_method`, `enable_inline_tax`, `currency_symbol_placement`, `enabled_modules`, `date_format`, `time_format`, `currency_precision`, `quantity_precision`, `ref_no_prefixes`, `theme_color`, `created_by`, `enable_rp`, `rp_name`, `amount_for_unit_rp`, `min_order_total_for_rp`, `max_rp_per_order`, `pv_limit`, `redeem_amount_per_unit_rp`, `min_order_total_for_redeem`, `min_redeem_point`, `max_redeem_point`, `rp_expiry_period`, `rp_expiry_type`, `email_settings`, `sms_settings`, `custom_labels`, `common_settings`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'ITR HELTH CARE LTD (UNANI)', 134, '2023-02-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25.00, 1, 'Asia/Dhaka', 1, 'fifo', 0.00, 'includes', '1720859595_itr logo.jpeg', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"weighing_scale\":null,\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}', '{\"amount_rounding_method\":null,\"cmmsn_calculation_type\":\"invoice_value\",\"razor_pay_key_id\":null,\"razor_pay_key_secret\":null,\"stripe_public_key\":null,\"stripe_secret_key\":null,\"disable_pay_checkout\":\"1\",\"disable_draft\":\"1\",\"disable_discount\":\"1\",\"disable_credit_sale_button\":\"1\",\"cash_denominations\":null,\"enable_cash_denomination_on\":\"pos_screen\",\"disable_express_checkout\":0,\"hide_product_suggestion\":0,\"hide_recent_trans\":0,\"disable_order_tax\":0,\"is_pos_subtotal_editable\":0}', '{\"label_prefix\":null,\"product_sku_length\":\"4\",\"qty_length\":\"3\",\"qty_length_decimal\":\"2\"}', 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 0, 1, NULL, 1, 1, 'before', '[\"purchases\",\"add_sale\",\"pos_sale\",\"stock_transfers\",\"stock_adjustment\",\"expenses\",\"account\",\"types_of_service\"]', 'm/d/Y', '24', 2, 2, '{\"purchase\":\"PO\",\"purchase_return\":null,\"purchase_requisition\":null,\"purchase_order\":null,\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"expense_payment\":null,\"business_location\":\"BL\",\"username\":null,\"subscription\":null,\"draft\":null,\"sales_order\":null}', NULL, NULL, 1, 'PV', 1.0000, 1.0000, NULL, 100, 1.0000, 1.0000, NULL, NULL, NULL, 'year', '{\"mail_driver\":\"smtp\",\"mail_host\":null,\"mail_port\":null,\"mail_username\":null,\"mail_password\":null,\"mail_encryption\":null,\"mail_from_address\":null,\"mail_from_name\":null}', '{\"sms_service\":\"other\",\"nexmo_key\":null,\"nexmo_secret\":null,\"nexmo_from\":null,\"twilio_sid\":null,\"twilio_token\":null,\"twilio_from\":null,\"url\":null,\"send_to_param_name\":\"to\",\"msg_param_name\":\"text\",\"request_method\":\"post\",\"header_1\":null,\"header_val_1\":null,\"header_2\":null,\"header_val_2\":null,\"header_3\":null,\"header_val_3\":null,\"param_1\":null,\"param_val_1\":null,\"param_2\":null,\"param_val_2\":null,\"param_3\":null,\"param_val_3\":null,\"param_4\":null,\"param_val_4\":null,\"param_5\":null,\"param_val_5\":null,\"param_6\":null,\"param_val_6\":null,\"param_7\":null,\"param_val_7\":null,\"param_8\":null,\"param_val_8\":null,\"param_9\":null,\"param_val_9\":null,\"param_10\":null,\"param_val_10\":null}', '{\"payments\":{\"custom_pay_1\":\"bKash\",\"custom_pay_2\":\"Roket\",\"custom_pay_3\":\"Nagot\",\"custom_pay_4\":null,\"custom_pay_5\":null,\"custom_pay_6\":null,\"custom_pay_7\":null},\"contact\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null,\"custom_field_7\":null,\"custom_field_8\":null,\"custom_field_9\":null,\"custom_field_10\":null},\"product\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"location\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"user\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"purchase\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"purchase_shipping\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null},\"sell\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"shipping\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null},\"types_of_service\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null}}', '{\"default_credit_limit\":null,\"default_datatable_page_entries\":\"25\"}', 1, '2023-02-23 22:00:02', '2024-08-01 15:03:20');

-- --------------------------------------------------------

--
-- Table structure for table `business_locations`
--

CREATE TABLE `business_locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` varchar(191) DEFAULT NULL,
  `name` varchar(256) NOT NULL,
  `landmark` text DEFAULT NULL,
  `country` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `zip_code` char(7) NOT NULL,
  `invoice_scheme_id` int(10) UNSIGNED NOT NULL,
  `invoice_layout_id` int(10) UNSIGNED NOT NULL,
  `sale_invoice_layout_id` int(11) DEFAULT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `print_receipt_on_invoice` tinyint(1) DEFAULT 1,
  `receipt_printer_type` enum('browser','printer') NOT NULL DEFAULT 'browser',
  `printer_id` int(11) DEFAULT NULL,
  `mobile` varchar(191) DEFAULT NULL,
  `alternate_number` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `website` varchar(191) DEFAULT NULL,
  `featured_products` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `default_payment_accounts` text DEFAULT NULL,
  `custom_field1` varchar(191) DEFAULT NULL,
  `custom_field2` varchar(191) DEFAULT NULL,
  `custom_field3` varchar(191) DEFAULT NULL,
  `custom_field4` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `business_locations`
--

INSERT INTO `business_locations` (`id`, `business_id`, `location_id`, `name`, `landmark`, `country`, `state`, `city`, `zip_code`, `invoice_scheme_id`, `invoice_layout_id`, `sale_invoice_layout_id`, `selling_price_group_id`, `print_receipt_on_invoice`, `receipt_printer_type`, `printer_id`, `mobile`, `alternate_number`, `email`, `website`, `featured_products`, `is_active`, `default_payment_accounts`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'HQ001', 'ITR HELTH CARE LTD (UNANI)', 'Mukterbari, Auchpara', 'Bangladesh', 'Tongi', 'Gazipur', '1212', 1, 1, 1, NULL, 1, 'browser', NULL, '01766855006, 01976685506', NULL, NULL, 'https://itrhcl.com/', NULL, 1, '{\"cash\":{\"is_enabled\":\"1\",\"account\":null},\"card\":{\"is_enabled\":\"1\",\"account\":null},\"cheque\":{\"is_enabled\":\"1\",\"account\":null},\"bank_transfer\":{\"is_enabled\":\"1\",\"account\":null},\"other\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_1\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_2\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_3\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_4\":{\"account\":null},\"custom_pay_5\":{\"account\":null},\"custom_pay_6\":{\"account\":null},\"custom_pay_7\":{\"account\":null}}', NULL, NULL, NULL, NULL, NULL, '2023-02-23 22:00:02', '2024-07-13 13:41:40'),
(2, 1, 'DEPO-ITRHCU-1001', 'Md Raju Ahmed', 'Mukterbari, Po- nishatnagor, Ps-Tongi, Dis-Gazipur', 'Bangladesh', 'Dhaka', 'GAZIPUR', '1704', 1, 1, 1, 0, 1, 'browser', NULL, '01780273399', NULL, 'depo0001@gmail.com', NULL, NULL, 1, '{\"cash\":{\"is_enabled\":\"1\",\"account\":null},\"card\":{\"is_enabled\":\"1\",\"account\":null},\"cheque\":{\"account\":null},\"bank_transfer\":{\"account\":null},\"other\":{\"account\":null},\"custom_pay_1\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_2\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_3\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_4\":{\"account\":null},\"custom_pay_5\":{\"account\":null},\"custom_pay_6\":{\"account\":null},\"custom_pay_7\":{\"account\":null}}', NULL, NULL, NULL, NULL, NULL, '2023-12-13 02:11:28', '2024-07-13 14:30:05'),
(3, 1, 'STOCKIST-ITRSP-0001', 'Md Raju Ahmed', 'Mukterbari, Po- nishatnagor, Ps-Tongi, Dis-Gazipur', 'Bangladesh', 'Dhaka', 'Gazipur', '1704', 1, 1, 1, 0, 1, 'browser', NULL, '01976685506', NULL, 'mdraju2u@gmail.com', NULL, NULL, 1, '{\"cash\":{\"is_enabled\":\"1\",\"account\":null},\"card\":{\"is_enabled\":\"1\",\"account\":null},\"cheque\":{\"account\":null},\"bank_transfer\":{\"account\":null},\"other\":{\"account\":null},\"custom_pay_1\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_2\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_3\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_4\":{\"account\":null},\"custom_pay_5\":{\"account\":null},\"custom_pay_6\":{\"account\":null},\"custom_pay_7\":{\"account\":null}}', NULL, NULL, NULL, NULL, NULL, '2023-12-13 15:50:40', '2024-07-13 14:28:30');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `expiration` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`id`, `key`, `value`, `expiration`) VALUES
(13, 'd68ebfd7ada0a376b775158906c27c28', 's:1126:\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC7ElEQVR4nO2dPY7TUBhFv0SULAAJELMGGhpAU6fMZlgAHRLNSNONkNhACooUSEizBgpqhNgEaJRQjDxyzPPP+792zmmjJM49ue+zHcVeHY9HAx0e1d4AXy63e+9v0O1us8qxLTlYKTckJPypqEqSEpJTwBgqgiSE1BTRpbaYakKUJPRRQ05xIXMQ0aWkmHWpNzKbpwyzsttdpCFzFeEid1uyClmSiC65xGQRsmQRXVKLKTpDYJykDTmnZnRJ1ZRkDTlnGWbpPn8SIecuoyFFDtFCkHFKbB5RQpDhJiaXYCHIGCY0nyAhyJhGSE7eQpDhh29eHBiKMfnAkGbEM+XgkYaIMUkI7UjDlBxpiBijQmhHWsbypCFiDAqhHXkYyrVXCDLy0pcvS5YYTiG0owyunGmIGAgR479zWTmXq/fvXtqbV0+cj+32P+3q5kfW57v4fPXWXjx77Hzsw/V323/77f2avrTPcdEQMU6EMMzr0M6dhoiBEDEQIsaDEOZHXZr8aYgYCBEDIWIgRIy1GQNdhcvt/khDxJjdxWf62G4ubLu5qL0Z0dAQMRAiBkLEQIgYCBFjMXtZX77+sutP/j/h3nx8bc+fun/CrcFihNzdHezP34P38w5ih8QsWWIgRAyEiLE2q3/hR7jndrdZ0RAxECIGQsRAiBgPQhjsdWnypyFiIEQMhIhxIoQ5Uod27kX/QQVuBv9BRUvK0s2bGSIGQsRwCmHZKoMrZxoiRq8QWpKXvnwHG4KUPAzlypIlxqgQWpKWsTxpiBiThNCSNHAh5RnifQ8qTj7647PC0BAxvIUwT/zwzSuoIUiZRkhOwUsWUoYJzSdqhiDFTUwu0UMdKafE5pFkLwsp96TIIdlu77lLSfX5uX13JNy+e+FkaUjDkpuSa4nOKqRhSWJyz8oiQhrmLKbUTkvRGTLXPbGS2120IW3m0JYaX6BqQtooyandYgkhDTXF1BbRICWkS05BKgK6SAtxESJJNXwX/wDjtkZSIeGq3wAAAABJRU5ErkJggg==\";', 2041239443),
(14, '9a41c2a7fd0f2fa70d9a8ccdb6da50f4', 's:2582:\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAHMElEQVR4nO2de2hTVxzHvzdJ0zZt+kibtma17frQaudkrpsgboLKNjYRQXEwRAoKY0P2lMrGYIONobi5jTHnHzIQZA/HhIGIjDncENc5qNWtZWo209jYV9qmL9M87/6Q1DS95+be5J6bm5vz+fck95z7++R3fueee5NwPM+DoR1MmR6AXLjzvbI/QfymNo7GWGjAaTlDUgm+VLQqSVNCaApIhlYEaUJIJkUkkmkxGROiJQkkMiFHdSHZICIRNcUY1OoIyE4ZgLrjViVDslWEELSzhaoQPYlIhJYYKkL0LCIRpcWoWkMYyVE0Q3IpMxJRKlMUy5BclgEod/6KCMl1GTGUiEPaQpiMhaQbj7SEMBnCpBOXlIUwGeKkGp+UhDAZ0kglTrKFMBnykBsvdmGoMSRfGLLMSB8pF48sQzSGJCEsO5RBShxZhmiMpEJYdihLsniyDNEYokJYdtBBLK5EIUwGXUjxZVOWxhAUwrJDHYTizDJEYzAhGmPRXpYS09XIE8thNwt/9WT7NTdOj07LOp6Z4xDYuJLY/ujlf9E9PSf5eK0WM7ZUWtFeUoiVRfmoMptQYjTAwAFT4ShccyF0T/txbmwGZ7zTCFOewOP3uLLuCzupYgCwq6YUb9RVYrW1gPg6u9kAu9mEx0oK8eIDNgwGQvjg1iiOeSYQVWmc8+i1mLdbC9Cztgkn2mpFZQixJD8PX7Q68MuaBthMRirji4+77mvI/roKXGpvxKpieSIS2VBehJ/X1MNioPsgvG6FmDjg67ZaHG6pQZ5CQXzEWogjy2oUORYJ3QqhVYj3OsqxzGKmc3DECdFj/ejo8+D3ybuCbf5IFN8PT2L7NTfaupyo+PUfrP7DiddvDGI0GCYe08hx2F1TpvhYY/HX9SoryPPYdtWNy483or7g/qf6m6FJdDqHMBBYGPjxmQiuzQRwangKPWubiEv39WUWamPW7ZQVYyQUwZYeN6bDEQwHw3j6igsv9A4skhHPnWAYxzwTxPa6gjwaQwWg8wyJ8fdsAM/2uOH0BzEkMh3F0z3tJ7bRXGjlhBAAuEioJSRMHDnqI8FIusMhYgD0WdDTpbmQvJL6zx+k0id3vpfXfQ1JlW12K7HtrFfeXpwcmBABNpcXYW2p8EpqNhLFGe8Mtb6ZkASKjQYcbV1CbD86MI7xMOUawrjP8RUOtFjyBdtGg2EcdHmp9s+ExHGwqRrPV5cS2zv6PFSzA2BC5umsr8CBhkpi++F+L86O0asdMZgQAK8steFQM3kX97vhSXQ6h1UZS84L2Vdrw2fLyEX8x9Ep7OodUG08qgsxiFwBk99DYSC4J+Pz5WQZP4xMYcdft6nfU4+HihCxe8/FRvldlqTwnmS8tlRcxolBH3aqLAOgJMQXIq9Eaghb2mI48sV3V2ci8h4/6KyvwCci09Thfi86+jyqPNSQCBUhIyHyjuoamQ8ZSHmPV8Zm3zsNlcQCHuF5vHlzSLUCLoQBUP4nhlz+ELHtmYpi2Q8K7BS5NhgMhCRfG7z3oB3vN1ULtoWiPDr6PDjiHpM1NiXhN7VxVDLkp3Hyet1qMqKznrzeT2R9qQWbbUXE9os+advqHzZV4d3GKsG22UgUW6+6cXJoUvK4aEFFyLmxGYSi5Gr4doMdex3J70u3WwtwalUtjCIrs2+Hkwfxo+ZqvNVgF2wbC4WxuduFcyIfIjWZf5RU6Xsix1c4sMdRLvqaP6f8ODnkQ9ekH95gGEGeR5nJiIeLC7DVbsWOqhJRGddnA1jZ5RQtvp+21ODVugrBtlCUx1NXXOibDUg5pQVEAXhFFi+pwG9q46gJcZhNuLGuBUUUlqwxnuvpF93OOLp8CV6qtVHp+5Y/iMZLNxU95oIaonRhvxMMY3fvACKUfmTz4yR7SzaTkZoMGsTiT/VK/fToNPZdH1RcypcD49ifwaUpTahvnRzzTGBjtwu358hLYalMhCLY0+fBy9cHFRiZNlFlL+s331081OXEAecQ+ufkPyAwGgzjkMuL5ks38dWgj8IItQOVL+yIYQDwZJkF68osWFdqQUNBHmx5RpSZjDBxHGYiUXhDYTj9QXRPzeHCxCwu+GZl7ynZTEaMbWilcg6AskU9vn6rLoSxmHghi6asTP9/Rq6RGO+cv0GlNZgQjSEohE1b6iAUZ5YhGoMohGUJXUjxFc0QJoUOYnFlU5bGSCqEZYmyJIsnyxCNIUkIyxJlYD+knIXI/g8qtvkoHzkzDMsQjSFbCKsn8pAbr5QyhEmRRipxSnnKYlLESTU+adUQJkWYdOKSdlFnUhaSbjwUWWUxKfdQIg6KLXtzXYpS58/+vjtN2N936xwqGTJ/cB1nCq0pmqqQ+U50JIZ2rVRFyHxnWSxGrUWLqjUkW1diao5b1QxZ0HEWZEsmPkAZE7JgEBqSk+ks1oSQGJkUk2kRMTQlJBGagrQiIBFNCxEiFUlaDb4Q/wOYGd1vY/ybrgAAAABJRU5ErkJggg==\";', 2041255890),
(15, '84ad7de2a02a7c86b0ab7c5f9c60ff9d', 's:2814:\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAH30lEQVR4nO2dW2gcVRjH/zOz2c3u7GYvbbeN2EatD7ZVlFZFK9a2Coog+GBFpPRFFAVBwTdR8EFQwctDn+yDT/ogFhH0SfDWtPFeb4hoidW0TWuSNnub2evM+LDdZHfnzOxczpmdJOcHgWTOzDnffP/5vnOb7AqGYYATHiLDNsAtJ6d3u36Cdm6dEljYwgIhzBHixflOCatIoRKEpQCDCItAoRBkmEL0M2xhhiZImESwYhjiBC7IShCinyCFEYNqCFiZYgDB2h1IhKxUIUiwjhamgqwmIfphJQwTQVazEP3QFibQPoQzGKoRspYiox9akUItQtayGAC9+6ciyFoXowMNP/gWhIvRi19/+BKEi0HGj188C8LFsMerfzwJwsVwhhc/uRaEi+EOt/7iE8OQ4XhiyCPDP04mjzxCQoYjQXh00MGJH3mEhIyBgvDooMsgf/IICRm2gvDoYIOdXy0F4WKwxcq/PGWFDKIgPDqCgeRnHiEhgwsSMkxrWU7S1TUbX0EmedfAyk//9xIWK596Nm5EWo/rJz6CINg/N5qu4pfT99ie49Rmw2hB06vQjSo0rYxa8wxqjdNQ63+gVP0OhtFwdQ9O6F7jYvoPOxl5jy9BMsl9A8WgjSBEEJFSAFJAJI94bCuAvQDawheVSZxffAf15hkm7ffcLe3OfCxxGwQfmmfl/RSt8Y8kJpBL3Yttm9/FFbknqdXb7Xemj58kJpBK3OLp2oiUgzx6A2WL6CAKI9iUPYSJ/Av066ZeYx8ZeXDeJpGV9weertyyLnU/Now9RLVO5necTtzh6bpMch9lS6zRjSY0XYWmqzCMlqtrx3OPQxLHqNmylOBZTQZHIusgx3ZAqf/u3Cgph+TojSzMIbJQ+ghnF95a+lsQoohGxpEcvQG51H1IxXdaXhuRUsjIe3Cx/IkvG05O7zZ2bp2imxOU2h/E42mXaSsj7yWmK7X+pye73GIYDdSb/+Ji+ROcmn0aM/Ov257vNQuQoCpIUT1BDPmMvMdVPdnk3aZjLa2Akvq9Z9v8sFD6EEX1a8vyWHQLtbaoCmIYTVRqv5qOj0a3IDYy4aiOiJQlpquCcgyiEPVto1dKirUgI1KWWjtUBRHFOIrKJLHMaZRYpavFymcQxVFf9vlB08uWZQLFB0UE6HXokiijoHxFLHMqCDldFVGu/gBRiPmyzw/RyCbLspZWpNLGyendBtUIkYQEGq0LqNanTWWJ2DZEpJzt9e10dZPpeFtkA6IwvAjJEB6UDjQHG9RTFtDO9/0Igjhwkmidrj7vqT9YBFy57lkkYtdanlFQvqTWGl1BLj/BXtNWVjZPBtvp6sd2/YH0IRIkcQyJ2Hbk049g++b3kM88bHl2vXkehcsPDA2orvZ2HFZt/IVGaw7RSL6nPBnfCVFIQDdU07WSmEYyTkpXxwBo7foZ9SH59AHk0wdcX2cYOmbmX4MBd7N7O6hGSPdogzTaEoURpOXdxGuzyb0QBPPzUah80fWX5NtGmpy7eBjl6ndU66ScskaWfi+4HP5mLNJVqbo8GRQQik9Qgq7X8M/cy5grvk+9bsobVMsOK1d/hKYrkES554yxxO1oP+na0jFJHCOuFxWV4z3nhYGCMolzC4dRb51lUj/D1V4NRWXKdFQSZaTiu3qOZeS7iOlqsfIZM+u8UGvM4O8LzzMTA2C8/F5UnaWtbNK8M9jSyj3piiW6XkOzdXHpR9PNgw6gvQQ0nnuMqS1sBVGmoBtN0/G0fOfS7+10tct0TrFrdMWahfLH+O3fB5Z+/jr3lOW+yKbMQSRi1zGzhakguqGiUv3JdDwa2YBEbDuAdrQQ05VCb2zvlmrjFOaKHxDLBCGCifyLvt4VsIP5jiFp1g4spy3SzmBLK6Ok0h1OumX20hE0mheIZfHo1RjPPcGkXRFg+6Fcdqu/kphEKn6z+Rp1EsMeXRlGHTMLb1iWb8w8Cjm2g2qb1HcMSTS1eeLi22j0KmzMHOqZu3RY7JkMDo+SegKLlS+JZYIgtlMX5T2aQF7rsFrb2pQ9aDqm6QrK6resTXLM2YU3oekKsWw0uoXq+1lAQIJYpS0SBWWS6tqQX5raAmYvHbEsz6cfJm4ZeCUQQaqNadSb5x2dG7bJIADMF49avsCxnLroLHwuCcL60zat0lY3YUtXyxiYmX/Vcm4SGxnHleue8dVCx/+BvRroJG2FLV11056bHLUs35B+EKn4rb7bCUyQSu3ngXvPNDd6WDB76W00WnOW5RP55yGJSV9tBPjyrGH7bpOmKyip3wRnjgcMo44zNi/NRSN5bF7/nK82egRh3Y8UbfqRonI8tOmqm6J6HIWK9X3kUvcS93bs6Pa7p/+g4tClWxBTyhr292esNfr9He5/wFiDcEFCBlEQnraCgeRnHiEhw1IQHiVssfKvbYRwUdhg51eeskLGQEF4lNBlkD95hIQMR4LwKKED/yDlFYjr76Dii4/ucZNheISEDNeC8P7EHW795SlCuCjO8OInzymLi2KPV//46kO4KGT8+MV3p85F6cWvP6iMsrgobWj4gdqwd62LQuv++dd3+4R/ffcqh0mEdFjNkcIqRTMVpMNqEoZ1XxmIIB1WsjBBDVoC7UNW6kgsSLsDjZBuVkK0DOMBGpog3YRJnGFHcSgE6TBMYYYtRIdQCdIPS4HCIkA/oRaEhBeRwup8Ev8Dgd0Y+MDu9WIAAAAASUVORK5CYII=\";', 2041409550),
(16, '5503c3cc0f9a63027fd8171e8c4da9b3', 's:1134:\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC9ElEQVR4nO2dvW4TQRhFxxYlCFo6CE2k9NQIRB0h2nR5DFokHoA6HQ0FQinyBGnSUQCSRYEQT4GEHFNEG9nL7M/8fDN31+e0lpPxPb7z7a7k3cVms3Ggw53aCwjl7PA8+Bt0ujpeWKzFgoVyQ2LCH4uqJCkhlgKGUBEkIaSmiDa1xVQToiShixpyiguZgog2JcUsS/0j56Ypw7my6y7SkKmK8GHdFlMhcxLRxkqMiZA5i2iTW0zRGQLDZG3IPjWjTa6mZGvIPstwLt/nzyJk32U05MghWQgydknNI0kIMvyk5BItBBn9xOYTJQQZ44jJKVgIMsIIzYsTQzFGnxjSjHTGnDzSEDFGCaEdeRiTIw0RY1AI7cjLUJ40RIxeIbTDhr5cO4Ugw5aufNmyxPAKoR1l8OVMQ8RAiBj/Xcuy3K5evH/qHr186H3t+4ef7urtV9P3+3h98dw9eHLP+9rlmy/ux6ffwX8zlO1rXDREjB0hDPM6bOdOQ8RAiBgIEeNWCPOjLk3+NEQMhIiBEDEQIsbSOQa6CmeH5xsaIsbkbj7TxdHJgTs6Oai9jGRoiBgIEQMhYiBEDISIMZujrNXHX+7q3bfg9736/Mzdf3zXYEVxzEbI+u+1W/9ZB79vc611TsyWJQZCxECIGEvn6t/4EW44XR0vaIgYCBEDIWIgRIxbIQz2ujT50xAxECIGQsTYEcIcqcN27kV/QQV+en9BRUvK0s6bGSIGQsTwCmHbKoMvZxoiRqcQWmJLV769DUGKDX25smWJMSiEluRlKE8aIsYoIbQkD9xIeYIEP4OKi4/hhOwwNESMYCHMkzBC84pqCFLGEZNT9JaFlH5i80maIUjxk5JL8lBHyi6peWQ5ykLKDTlyyHbYu+9Scn1+Ht+dCI/vnjkmDWmYc1OstmhTIQ1zEmM9K4sIaZiymFIHLUVnyFSPxEquu2hDtplCW2p8gaoJ2UZJTu0WSwhpqCmmtogGKSFtLAWpCGgjLcRHjCTV8H38A66pRtB26h99AAAAAElFTkSuQmCC\";', 2041429282),
(17, 'e3875c2b8bfdd31473e810770c437d8a', 's:2370:\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAGkklEQVR4nO2du3MbVRSHf6uVZEuxY8vSDGZix5Ng2ZMhDxgSk4dTU6SAIukpaehcwZ9AaFLRUNCmBTOThoGJwU4CCZ6Ehx3JjyRAYluWFD8kWS8KZR1Je3e1r7v37vp+lefurvbofDrn3l3JklSv1yHghyDrAMxyfeaK6VfQ1OS0RCMWGkg8V4iV5BuFV0lcCaEpoBO8COJCCEsR7bAWw0wITxK0YCHHdSFeENGOm2ICbp0I8KYMwN24XakQr4ogQbtaqArxk4h2aImhIsTPItpxWoyrc4igM45WyEGqjHacqhTHKuQgywCce/6OCDnoMhScyINtIUJGK3bzYUuIkEHGTl4sCxEy9LGaH0tChAxjWMmTaSFChjnM5ktcGHKG4QtDURn2MXLxKCqEMwwJEdXhDEbyKCqEMzoKEdXhLJ3yKSqEM3SFiOqgg15eNZe9Tsj48MTnSMYvdtxveuEL/LX+o+XzHAoP4JNz30CS9At+r1rAjdmruvvoxXz/32/xw9JXluNsh7QM5qJljcYv2Dp+PD7ZUYZXID4Lt1vVsdh7CEjWP/c9lph0MBr3IOWZi5dVWI5gpP8dS8dGQzEcOXzC4YjYwYUQAEhabFvjiUu+aVcAQQirldVbAxOWjvNqu1Jozzc3L61D4QG82Ttu6phoKIahw29TiogNLULcqo7nW4vEcbNtayxxkdiuXmynLMXFiua8M6mQ9OZd1OpV1bjZ5e944rJqbLecx2rugeXYWMNESLVewbP8H6rxgcgQBiJDhh4jGuojtqtUZhZyIGw7RlYwERKWI0hvzhG3Ga2SZJy8ulrYuI1QoMtWfCzZf0Zurq7CchSPM7PEbUbnEVK7KpS3sJqbR9CDQpT8M6qQbrwsrWF9Z0W1bbAniWgopnt8NNSH4b6TqvHHmZ8B1BGSvSdEgYmQkBwB0Oj37UhSoGOVaLermcbjByIORMkGNkJetRSrbWsscUk1Vihv4UluvvH4okLMofT4tZ00tkobqu3DfacQlsmv8kjwMIb7TqnGU5lZ1FF79fgeX2W5fbukOWGpjHq1JQdCOB47Rzw2mbiIgCSrxhcyM/t/S4TtXuD6zJU6kwqRA69vtadMLn/H4up7V4XyFlazry8GJXDxpQyWYCKkOWFPcvMoVXZV+xyLnYXUFl53sAdH+0+r9k1vzu23K6/D/OZiHTUsZe+pxruCURztP9MyloxfIrarvzduU4vPbZgLAYA0YR4B1KutccKt9mJlu6VdeR0uhCxl76FaK6vGRwfO7//daFdnVPs0r678ABdC9qoFPM0/Uo33dMUx2DMGoDHJE1dXGzOqMS/DhRAASG3qXySOE1ZXxco2VrL3qcblNvwI0ZhHRuMX0CUfIrardOaOr9oVwJGQ7b0M8Z2+eHQY7w9fgxwIqbb5rV0BHAkBtO9tTQxdU42VKrtYyfmrXQGcCdFa/pJIbc6hVq9QjIYNXAlZ311BvvjC0L4L6/65GGwmALD/4sdmtNpWM35tV1OT0/x95E/rvfZm/NquAM5aFgA8zT9Cobylu8+iD1dXCtwJAerEm40KpcoulrO/UTt7UNJ+c6tSK1I7rwKHQsjvtSukN+9QbVfdoV7NbcXKDrXzKrT8B5X4FzYJn56/ia5glLj11uMbePjiFpUzKwsrLiuEFcN9JzVlAMD6zjL1GISQVwSkIC6PfKy5vVorY21niXocnvv9ELuM9L+LSLAXmcIzFMp5yIEQBnuSmBi6ijd6RjWPW8397spSu0XI1OS05Pd55FjsLM4e+cj0cQ/++45CNA2aL8xFyzLAPy//xHL2V1fOpRLC020UHtirFvD94pfUHr8936JCdNgt53Hz4WfIF5+7ds4DN6kboV6vYTHzC35a/hovS2uunpvqV2vwyPHYBE4PfoBEdATdoV6E5QjK1RIK5Txyxed4kp9HOjOHTOEp9VhI08OBq5Cl7F0sZe+yDkMTzTlETO500cqv7qQupNBBL69ilcUZHYWIKnGWTvkUFcIZhoSIKnEG8UXKHsT0b1D59YKRJmY6jKgQzjAtRMwn5jCbL0sVIqQYw0qeLLcsIUUfq/mxNYcIKWTs5MX2pC6ktGI3H46ssoSUBk7kwbFl70GX4tTzFz/fbRPx890+h0qFKPi5Umi1aKpCFPwkhvZc6YoQBS+LcWvR4uoc4tWVmJtxu1ohzXihWli8gJgJaYYnOayrmAshCizFsBahwJWQdmgK4kVAO1wLIWFFEq/JJ/E/nXuEaL7wuSgAAAAASUVORK5CYII=\";', 2041519481),
(18, '0e7b1ae2c97a2ddd95c9e252d66c4446', 's:2682:\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAHe0lEQVR4nO2da2wURRzAf9dra7k+qRRQEAMqfahgLfgArI8ElZgYQyIaXx/UxMQYEzWamGiiIUSNnzTGoEZUNGg0PqKJj/jA4KMisYIgWi0KqECh0HKU9tre9fwwNG2vt3u7O7N7s+38kkvTzu7s3P/X/8zszPYaSafTGPShMN8NcM2mEve/Qc2JiA8t8YWI1hniJfhO0VSSXkL8FJALTQTpISSfIjLJs5j8CdFJghV5kBO8kDCIyCRAMQVBXQgIpwwItN3BZEhYRWTD52zxV8hEEpGJT2L8ETKRRWSiWEywY4ghJ2ozZDJlRiaKMkVdhkxmGaDs/asRMtllDKMgDvJCjIyxSMZDToiRkR2JuHgXYmTY4zE+3oQYGc7wECf3QowMd7iMl7kx1AznN4YmM+RxcPNoMkQznAkx2aEGB3E0GaIZuYWY7FBLjniaDNEMeyEmO/zBJq7WQowMf7GIr+myNCO7EJMdwZAlziZDNMMI0Yzxa1mququCUph2HVReDGWNUDwDCqsgUgypOAwegb4/oWcbxH+A7o2QHlRy6dAxao1LvZBoJcxdDTNugmiZ8/NSvdD1ORx8Ezo/AlJSzQgVlkJkZVRdBnWvQvFMqWoYOAi/XA29O+XqCRMnpKj7k7bKZXD2exCNydeVTkJvm3w9IUTNoB4th/oNamQAHFjHpOqyRqFGyJyHoXi6kqpIJ2H/y2rqCiEjXZbM+DH9RuuyoQHoWA8db0Bij/i+qBpitVB2PlSvgPLGkeM7P4KB/Z6bElo2laRpTkRGBnWvQmINsKjVuvzXVXD4Q/s6imfBjFtg5q3w5z3Q/bWnpoQeJUKqr4ZzPshedvxX+KnJY+uyULkMFn4x/uc7b4bOd0f9IAo1K8V9UFmjmPVFCsTsbaAD4i3Q+QHEv7e+VsVFULMKKpdCyeliCp+Mw2An9GyFri/h4FuQ7lf3/poTEflZVuFU67KBA9LVO6LqkhEh5RdA3TqYcub440rmiFfFYph9Lxz9DtruhMTfI8cUnwLz10L1VePPL6o+0d3Oh+mrYN4aaL8PDr2j7K3ID+qDh63LyhZC5CTpS+Sksll8rbkezvsqu4ys5y2Fpi0Qqxffx+ph0c/ZZWSjaBrUvw6z73PfZguEEJkBPbHHuqxoGtS+BEQ9V++I0gbRPc1/AdwmfbQMGt6E0gVw9jtiecctc1eLzJRlU0laPkP62qD3D+vy6aug8VuoWCJ9KVsa3vJ+HxSrg6YfnWdWJpFCOO1Bb+dmoOY+ZP9L9uXljaIrOfcTsbwSBMluiG+G7m/EQOyWdFIsfHZthL723MeffI24QZZEjZD/noNjP+U+burlsOBTaGyBaSuVXHocqR5ouwu+nwVbL4VflkPLabD7ced17HtRnNN6IWxfAVvOgW1XCslWRAqgfLF08xXth6Rh502Q2Ovs8PJGaNgATa3qxfx2G3S8xtillzTsfQIOvZ/7/H1rof1eSHaN/fnRTWJGZUes1m1rx6Fug6p/D2xbbj+eZFLaIMQs+AymnCXfhq6NcORj6/JcXWsyDn8/al1+8G37LPEyIchA7Y5h/x6R5v8+K/pgp1RdCue3QM0NctfvfM++PFe3euRTSB2zOSAlxhUroqX29TtA/RbuUB/89RBsWQgdG5yLiZZB3Ssw8w7v14632Jenjoq1NCuObcl9jcFDNoXy4fRvTz2xC9puhx/r4b/nxY5gLiIFcNYzYtHRC327ch8zZNMOJ+c7eR8S+P+QQ/8/sOt+2HwG7H1SzILsiBTCvKfcXyfVK7JThlRc7nwFBPfUSbILdj8Gm2vF4GhH1SVQMtdd/Xa/+Y7rSMjXIUnwjwElD8Pvt8Hu1fbHub2zdzOJ0Jj8PZe1dw30bLcuL5kTXFs0QgjJ1wc/9thMQyNFwbVDF5oTEfkMOf0RsXHkheJZ1mUDHd7qDDnyQqpXiF28RVvFvoBdkEdTsUSsbVmRcDAFnYCoey4rVgfznoC5a6DnZ/Fo6LFWOL5dbJ2m4lAQE+s9NSvh1Lut9y6S3WIZZBKi/rPfIwVQ3iReXjmwHvNcliYftU3/PndL5ROFE/HX688RBjthx7UwdDzfLckb8kLSQwqagVhF3bYcju9QU19IkRey4zqxh+BkmzMbfe3Q/gC0XgS9v0k3J+yMHdSbExHXT6AkD8M/T4tXyRkw9Qrx+M+UWvGAWWGFmF0xJDaAkkfEk+09W8VMLP6DwrcTUnz9gx2De0YJGd9l6TLbmixkxFuvWZbBCNGN7EJMtxUMWeJsMkQzrIWYLPEXi/jaZ4iR4g82cTVdlmbkFmKyRC054mkyRDOcCTFZogbzQcrhw/3/oDKLj+5x0cOYDNEM90LMeOIOl/HyliFGijM8xMl7l2Wk2OMxPnJjiJGSHYm4yA/qRspYJOOhZpZlpAgUxEHdtHeyS1H0/s2/75bF/PvuiY0/GTLMRM4Un7pof4UMM5HE+DxWBiNkmDCLCWjSEuwYEtaZWIDtDjZDRhOGbMnDL1D+hIxGJzl5zmI9hAyTTzGadKd6CcnET0GaCMhEbyHZ8CJJ0+Bn43+vf3wQlE+rMQAAAABJRU5ErkJggg==\";', 2041519520),
(19, '8455bf155a1150b8628249bd83c2b3c0', 's:2338:\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAGeUlEQVR4nO2dyU8bVxzHv17GZktZYjAQKCZR0qjNIjUCparSNSFtL5wq9VIpEm3/gKrqrbfeeuw5l6o99RSpFU0EFBqlRU0aVYqIaKQQMGDssDkswdgY92BMbM+b8Wxv3pvx+xxnsR+/j7+/92a84MnlchDwg5/1APRy/fQN3a+goelBD42x0MDDc0KMFF8rvEriSghNAZXgRRAXQliKKIe1GGZCeJKgBAs5tgtxgohy7BTjteuJAGfKAOwdty0JcaoIErTTQlWIm0SUQ0sMFSFuFlGO1WJsnUMElbE0IdWUjHKsSoplCalmGYB1f78lQqpdRgEr6mBaiJBRitl6mBIiZJAxUxfDQoQMdYzWx5AQIUMbRuqkW4iQoQ+99RIXhpyh+cJQJMM8Wi4eRUI4Q5MQkQ5r0FJHkRDOqChEpMNaKtVTJIQzVIWIdNBBra6Ky14rZLz/fT8iVzoqHjf+1T08/mXR8PPUtdXgk/EBeLzqq8rM9h5+uPCr6jFqY576cQaT3z4wPM5ySMtgLlpWz+XK0tSIXO2sKMMpEIXY3aq6LoXhlYwXtPdqp4WjsQ9SnblIiFTvR+cbbYbOrQ0FEX69xeIRsYMLIQAQudxu6LxeF7UrgCCE1cqq+11jQiIfOLNdFSivNzcJqWutQev5Zl3n1IaCaL9wlNKI2FAixK50LD9YJ26P6FxtRQY6iO1qZSppaFysKK47k4TMjyewv7cv2653+dv74THZttTaLmJ/LhseG2uYCMlm9pH4Z022vbG3AY3HGzQ9Rk1LgNiu5kaW4Aty04l1w2TkUp0fc2NLxH1aUxIZIK+uZoZj8Nf4TI2PJYdC7FxdSQ1+zI2YE3Kc1K6SacQml+GrddyXiw/rzywhW4s7WHu0IdvXeqYJtaGg6vk1LQG09xHa1a0YkIM7EmInUl2+YKSUeLyeiilRaldPbsbyj18vhOjCX6ssBKjctkj3rvLtaiX/+CIh+vDX5Hv86sNn2I7vyPZ39Icg1ZPngWCzQrsaWUIum58GfUGHC7H7dknxsnRuNC7fH/Ci++0w8dzIlQ54/fLX0exBuwIAr8+Z97aun76RY5IQr/TiaaM6l7+9hHtXqWQai8UXgw6+2chESPGEHJtcQXorIzum6602eMpe6cFGCR39Idmx0bH4YbtyOswvaXPZHOYnErLtgQYJnRdLi98z0ElsV0+Gjb/9yxvMhQBAlDCPAPK2RVpd7W5kStuVw+FCyPxEAtm0/Gbjy++9eI8k2ChPDFC6unIDXAjJbO8hfm9Ftr0+XIvWs00A8mkhtqvfYrJtToYLIUDli8SIUru685TquOyGHyEq80jgiB+dF1tl+6Jj7mpXAEdCnidSxHf6mk4cwfkvTsEXcH+7AjgSAii3rXOfn5RtS2+5r10BvAkZI7ctEtHROPYz7mpXAGdC1v/bwObCc03HzrjoYrAYL8D+hx+LUWpbxbi1XQ1ND3q4SggAxffai3FruwI4a1kAEL+7ilQyrXrMk5vuW10V4E4IcsAC4WZjgfRWBgu3lfebRe0jRNmdLLXnLcCfEACzKvNI9PcE1XYVbAoo7tvdlL9NYDUl36Cq+q+weYBP736EQINE3H37m3/x6Oc5Kk9dWFhxmRBWtPcdVZQBAOvTz6iPQQg5wCt50Pflq4r7s+l9rNogxHkf8TPJsTdbEWwMIDmzidR6Gj7Ji9DZJpz77CRCrzUpnhf766ktS+0SIUPTgx63zyNdl8I4c+2E7vMe/jRr/WAOKL4wFy1LA4n7q1j4g95SuxiZEJ5uo/BAZnsPE1/fp/b45fUWCVEhtbaL4Wt3NN/wtIKqm9S1kNvPYfZWDH9/N4WtRflHXWlC9ac1eKT7nTBe+bgHzadeQrAxAKnOh71UFqn1NDbntxGbXEF0NI7k403qYyFND1WXkPnxBObH7ZmgjaA4h4jJnS5K9VWd1IUUOqjVVayyOKOiEJESa6lUT5EQztAkRKTEGsQPKTsQ3f+Dyq0XjDTR02FEQjhDtxAxn+hDb70MJURI0YaROhluWUKKOkbrY2oOEVLImKmL6UldSCnFbD0sWWUJKXmsqINly95ql2LV3y/+fbdJxL/vdjlUElLAzUmh1aKpCingJjG050pbhBRwshi7Fi22ziFOXYnZOW5bE1KME9LC4gXETEgxPMlhnWIuhBRgKYa1iAJcCSmHpiBeBJTDtRASRiTxWnwS/wOqF4isq7lDLQAAAABJRU5ErkJggg==\";', 2041579754),
(20, 'dd9a0e29c467a12909adece9e5bbddf5', 's:2254:\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAGO0lEQVR4nO2dy28bRRzHv+v1I85DSWmSQqhS4iAhJGgpiFJAKAhQ+oA7F8QBDpAb4oDEkRN/QjlwQZy4VpRUqQlBtEFCICEoL9E4SZu0FbRN5CSK4+x6ODhL1ruz633Nzux6PsfUdXZ/n/n+5mHHVgghkIhDlvcF+KV0btP3CKpM9SosroUFisgJCVJ8r4gqSSghLAW0QxRBQgjhKcIKbzHchIgkwQkecmIXkgQRVuIUk4nrFwHJlAHEe92xJCSpImiwTgtTIWkSYYWVGCZC0izCStRiYp1DJO2JNCGdlAwrUSUlsoR0sgwguvuPREinyzCIog6hhUgZrYStRyghUgadMHUJLETKcCdofQIJkTK8EaROvoVIGf7wWy+5MRQMzxtDmYzweNk8yoQIhichMh3R4KWOMiGC0VaITEe0tKunTIhguAqR6WCDW10dl71RyPjkVBcmS+3frfpeuYbzf2uBf89wt4L5N7uRUdxXlVu7BI9/uuX6GLdr/uzXOj66XA98nVZoy2AhWtbkWLi3GJ8dz7aVkRSoQuJuVROjKnIhhsaZ8cS9ZxwAvc5CJKQnp+D5w2qg/ztYVPDU/ULcRiQIcydB21aa2hVAEcJrZfXyQ8ESktR2ZWCttzAJGerO4IlD/i5nsKjg6QeEuYVIaLmbuNLxyz869ed+29bpEr1dXf2X/vyiYq47l+E1u6xBa9jd+xXy6sP2x9/bJri8kiwhZrgIqevAj7fsRSsNZFAa8DZBH3RoVzOLGgrBpiMh4CKkJ6fg0lK4tnVqTKW2qwsLGorZ5K66/hcS5+qqN98cyTS8CnmN0q7WawTzKzqKCVx4GfXnlpDVDYK/7tpTcnQ4g8Gi+wg/WFRwYsTely5WNBAgHQmJk+5cs2Azi3YhGUXB5Jj7JODUrqYXtL3nj+AiOcFFiNFSHNtWmxPis5TN4HqNYH61KbiYkwnxhSHktzsN3Nps2P795IiKXodRfqAL1HY1s6hB35sFE7/Kivu4pKDuj+Dykj0leVXBi0foKTldyiKbsSfgq4X951ETGpDSuU3CJSE50wguU+YRAI7zyBlKO1uvEVwxbQYpvhIDFyHmgs2v6tio2wM6MZq1jfT+AnDyQbuo8tJ+u0o63E/mdALMLdvbVl9ewXOW4ju1qy+vBX/5VzS4CwHgvGu3tCfaUXt1p7VdJR0hhMwta6hTes4rptdI+guwJQZoXV2lASGEbO4CP9y0j/JDPRkcG25e4uRY+9VVGhBCCEDftQP7Z1u0zWB1h+C7G+lpV4BAQmj7EaAppC8PPEtpV5dStLoyEEbI7S1CfaVv/EAGU0/mkafs9qZT1q4AgYQAzmdb7x7P2362UU9fuwIEE1J2WP5SH7uoYdd+DJZ4hBLy590GVqreqnwhhe0K2BPC+4MfzTi1LTNpbVeVqV5FqIQAzrt2M2ltV4BgLQtobhDXa+5r2elKOtsVIKAQAuAbymGjwUad4Nvr7NpVweXFyu0YxoFwQgD3eWR2iW276i84T6fVHfa70Ja/oOr0P2FTAPz8dg/68nQpH87V8MUfbGJiLKyETAgvToyojjKA5rKcNVLIHrkM8MEz9hMBg7pO8Psd9kIS+B6/cLxwWEV/l4KFtQbWagQ5FTg6pOKd4zk8NuT8dpUrK3osS+0WIZWpXiXt88jEqIq3jjknwYnPr+4yuJom5o25bFke+Om2jjmGS20zNiEiHaOIwNYuwftf15g9v7XeMiEu3NsmeOP8Nm5U4+viHTepe6FBCC5WdHz8/Q5WN+KdUpl+tIaIvHRExeuP5vDIfRkMdCnozjWPRNa2Ca5XG5hf1VFe0nBtjf3t06aHjkvI7LKO2WVxj+4d5xA5ubPFqb6uk7qUwga3uspVlmC0FSJTEi3t6ikTIhiehMiURIP8IOUE4vs7qNK6YWSJnw4jEyIYvoXI+cQffusVKCFSijeC1Clwy5JS3Alan1BziJRCJ0xdQk/qUkorYesRySpLSmkSRR0iW/Z2upSo7l9+fXdI5Nd3pxwmCTFIc1JYtWimQgzSJIb1XBmLEIMki4lr0RLrHJLUlVic1x1rQswkIS08BhA3IWZEksM7xUIIMeAphrcIA6GEWGEpSBQBVoQWQiOIJFGLT+M/dc98xEV49kUAAAAASUVORK5CYII=\";', 2041579794);

-- --------------------------------------------------------

--
-- Table structure for table `captainship_bonuses`
--

CREATE TABLE `captainship_bonuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `month` varchar(255) NOT NULL,
  `total` float(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `captainship_bonuses`
--

INSERT INTO `captainship_bonuses` (`id`, `user_id`, `month`, `total`, `created_at`, `updated_at`) VALUES
(1, 121, '9-2024', 0.00, '2024-09-10 01:21:30', '2024-09-10 01:21:30'),
(2, 132, '9-2024', 0.00, '2024-09-10 01:21:30', '2024-09-10 01:21:30'),
(3, 133, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(4, 134, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(5, 135, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(6, 136, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(7, 137, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(8, 138, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(9, 139, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(10, 140, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(11, 141, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(12, 142, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(13, 143, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(14, 144, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(15, 145, '9-2024', 0.00, '2024-09-10 01:21:31', '2024-09-10 01:21:31'),
(16, 146, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(17, 147, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(18, 148, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(19, 149, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(20, 150, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(21, 151, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(22, 152, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(23, 153, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(24, 154, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(25, 155, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(26, 156, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(27, 157, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(28, 158, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(29, 159, '9-2024', 0.00, '2024-09-10 01:21:32', '2024-09-10 01:21:32'),
(30, 160, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(31, 161, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(32, 162, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(33, 163, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(34, 164, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(35, 165, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(36, 166, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(37, 167, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(38, 168, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(39, 169, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(40, 170, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(41, 171, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(42, 172, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(43, 173, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(44, 174, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(45, 175, '9-2024', 0.00, '2024-09-10 01:21:33', '2024-09-10 01:21:33'),
(46, 176, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(47, 177, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(48, 178, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(49, 179, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(50, 180, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(51, 181, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(52, 182, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(53, 183, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(54, 184, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(55, 185, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(56, 186, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(57, 187, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(58, 188, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(59, 189, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(60, 190, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(61, 191, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(62, 192, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(63, 193, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(64, 194, '9-2024', 0.00, '2024-09-10 01:21:34', '2024-09-10 01:21:34'),
(65, 195, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(66, 196, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(67, 197, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(68, 198, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(69, 199, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(70, 200, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(71, 201, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(72, 202, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(73, 203, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(74, 204, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(75, 205, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(76, 206, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(77, 207, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(78, 208, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(79, 209, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(80, 210, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(81, 211, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(82, 212, '9-2024', 0.00, '2024-09-10 01:21:35', '2024-09-10 01:21:35'),
(83, 213, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(84, 214, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(85, 215, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(86, 216, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(87, 217, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(88, 218, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(89, 219, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(90, 220, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(91, 221, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(92, 222, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(93, 223, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(94, 224, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(95, 225, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(96, 226, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(97, 227, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(98, 228, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(99, 229, '9-2024', 0.00, '2024-09-10 01:21:36', '2024-09-10 01:21:36'),
(100, 230, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(101, 231, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(102, 232, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(103, 233, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(104, 234, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(105, 235, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(106, 236, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(107, 237, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(108, 238, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(109, 239, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(110, 240, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(111, 241, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(112, 242, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(113, 243, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(114, 244, '9-2024', 0.00, '2024-09-10 01:21:37', '2024-09-10 01:21:37'),
(115, 245, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(116, 246, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(117, 247, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(118, 248, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(119, 249, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(120, 250, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(121, 251, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(122, 252, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(123, 253, '9-2024', 0.00, '2024-09-10 01:21:38', '2024-09-10 01:21:38'),
(124, 254, '9-2024', 0.00, '2024-09-10 01:21:39', '2024-09-10 01:21:39'),
(125, 255, '9-2024', 0.00, '2024-09-10 01:21:39', '2024-09-10 01:21:39'),
(126, 256, '9-2024', 0.00, '2024-09-10 01:21:39', '2024-09-10 01:21:39'),
(127, 257, '9-2024', 0.00, '2024-09-10 01:21:39', '2024-09-10 01:21:39'),
(128, 258, '9-2024', 0.00, '2024-09-10 01:21:39', '2024-09-10 01:21:39'),
(129, 259, '9-2024', 0.00, '2024-09-10 01:21:39', '2024-09-10 01:21:39'),
(130, 260, '9-2024', 0.00, '2024-09-10 01:21:39', '2024-09-10 01:21:39'),
(131, 261, '9-2024', 0.00, '2024-09-10 01:21:39', '2024-09-10 01:21:39'),
(132, 262, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(133, 263, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(134, 264, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(135, 265, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(136, 266, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(137, 267, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(138, 268, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(139, 269, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(140, 270, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(141, 271, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(142, 272, '9-2024', 0.00, '2024-09-10 01:21:40', '2024-09-10 01:21:40'),
(143, 273, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(144, 274, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(145, 275, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(146, 276, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(147, 277, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(148, 278, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(149, 279, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(150, 280, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(151, 281, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(152, 282, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(153, 283, '9-2024', 0.00, '2024-09-10 01:21:42', '2024-09-10 01:21:42'),
(154, 284, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(155, 285, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(156, 286, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(157, 287, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(158, 288, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(159, 289, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(160, 290, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(161, 291, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(162, 292, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(163, 293, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(164, 294, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(165, 295, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(166, 296, '9-2024', 0.00, '2024-09-10 01:21:43', '2024-09-10 01:21:43'),
(167, 297, '9-2024', 0.00, '2024-09-10 01:21:44', '2024-09-10 01:21:44'),
(168, 298, '9-2024', 0.00, '2024-09-10 01:21:44', '2024-09-10 01:21:44'),
(169, 299, '9-2024', 0.00, '2024-09-10 01:21:44', '2024-09-10 01:21:44'),
(170, 300, '9-2024', 0.00, '2024-09-10 01:21:44', '2024-09-10 01:21:44'),
(171, 121, '8-2024', 9.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(172, 132, '8-2024', 4.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(173, 133, '8-2024', 6.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(174, 134, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(175, 135, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(176, 136, '8-2024', 4.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(177, 137, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(178, 138, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(179, 139, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(180, 140, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(181, 141, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(182, 142, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(183, 143, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(184, 144, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(185, 145, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(186, 146, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(187, 147, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(188, 148, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(189, 149, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(190, 150, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(191, 151, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(192, 152, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(193, 153, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(194, 154, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(195, 155, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(196, 156, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(197, 157, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(198, 158, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(199, 159, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(200, 160, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(201, 161, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(202, 162, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(203, 163, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(204, 164, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(205, 165, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(206, 166, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(207, 167, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(208, 168, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(209, 169, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(210, 170, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(211, 171, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(212, 172, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(213, 173, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(214, 174, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(215, 175, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(216, 176, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(217, 177, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(218, 178, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(219, 179, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(220, 180, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(221, 181, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(222, 182, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(223, 183, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(224, 184, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(225, 185, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(226, 186, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(227, 187, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(228, 188, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(229, 189, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(230, 190, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(231, 191, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(232, 192, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(233, 193, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(234, 194, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(235, 195, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(236, 196, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(237, 197, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(238, 198, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(239, 199, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(240, 200, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(241, 201, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(242, 202, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(243, 203, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(244, 204, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(245, 205, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(246, 206, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(247, 207, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(248, 208, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(249, 209, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(250, 210, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(251, 211, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(252, 212, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(253, 213, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(254, 214, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(255, 215, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(256, 216, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(257, 217, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(258, 218, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(259, 219, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(260, 220, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(261, 221, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(262, 222, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(263, 223, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(264, 224, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(265, 225, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(266, 226, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(267, 227, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(268, 228, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(269, 229, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(270, 230, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(271, 231, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(272, 232, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(273, 233, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(274, 234, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(275, 235, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(276, 236, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(277, 237, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(278, 238, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(279, 239, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(280, 240, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(281, 241, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(282, 242, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(283, 243, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(284, 244, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(285, 245, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(286, 246, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(287, 247, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(288, 248, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(289, 249, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(290, 250, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(291, 251, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(292, 252, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(293, 253, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(294, 254, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(295, 255, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(296, 256, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(297, 257, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(298, 258, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(299, 259, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(300, 260, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(301, 261, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(302, 262, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(303, 263, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(304, 264, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(305, 265, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(306, 266, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(307, 267, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(308, 268, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(309, 269, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(310, 270, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(311, 271, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(312, 272, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(313, 273, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(314, 274, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(315, 275, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(316, 276, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(317, 277, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(318, 278, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(319, 279, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(320, 280, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(321, 281, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(322, 282, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(323, 283, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(324, 284, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(325, 285, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(326, 286, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(327, 287, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(328, 288, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(329, 289, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(330, 290, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(331, 291, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(332, 292, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(333, 293, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(334, 294, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(335, 295, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(336, 296, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(337, 297, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(338, 298, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(339, 299, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(340, 300, '8-2024', 0.00, '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(341, 121, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(342, 132, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(343, 133, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(344, 134, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(345, 135, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(346, 136, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(347, 137, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(348, 138, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(349, 139, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(350, 140, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(351, 141, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(352, 142, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(353, 143, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(354, 144, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(355, 145, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(356, 146, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(357, 147, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(358, 148, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(359, 149, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(360, 150, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(361, 151, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(362, 152, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(363, 153, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(364, 154, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(365, 155, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(366, 156, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(367, 157, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(368, 158, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(369, 159, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(370, 160, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(371, 161, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(372, 162, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(373, 163, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(374, 164, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(375, 165, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(376, 166, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(377, 167, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(378, 168, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(379, 169, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(380, 170, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(381, 171, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(382, 172, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(383, 173, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(384, 174, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(385, 175, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(386, 176, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(387, 177, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(388, 178, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(389, 179, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(390, 180, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(391, 181, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(392, 182, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(393, 183, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(394, 184, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(395, 185, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(396, 186, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(397, 187, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(398, 188, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(399, 189, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(400, 190, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(401, 191, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(402, 192, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(403, 193, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(404, 194, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(405, 195, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(406, 196, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(407, 197, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(408, 198, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(409, 199, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(410, 200, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(411, 201, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(412, 202, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(413, 203, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(414, 204, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(415, 205, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(416, 206, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(417, 207, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(418, 208, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(419, 209, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(420, 210, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(421, 211, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(422, 212, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(423, 213, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(424, 214, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(425, 215, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(426, 216, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(427, 217, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(428, 218, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(429, 219, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(430, 220, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(431, 221, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(432, 222, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(433, 223, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(434, 224, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(435, 225, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(436, 226, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(437, 227, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(438, 228, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(439, 229, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(440, 230, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(441, 231, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(442, 232, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(443, 233, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(444, 234, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(445, 235, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(446, 236, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(447, 237, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(448, 238, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(449, 239, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(450, 240, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(451, 241, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(452, 242, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(453, 243, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(454, 244, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(455, 245, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(456, 246, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(457, 247, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(458, 248, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(459, 249, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(460, 250, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(461, 251, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(462, 252, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(463, 253, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(464, 254, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(465, 255, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(466, 256, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(467, 257, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(468, 258, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(469, 259, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(470, 260, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(471, 261, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(472, 262, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(473, 263, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(474, 264, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(475, 265, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(476, 266, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(477, 267, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(478, 268, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(479, 269, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(480, 270, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(481, 271, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(482, 272, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(483, 273, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(484, 274, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(485, 275, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(486, 276, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(487, 277, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(488, 278, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(489, 279, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(490, 280, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(491, 281, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(492, 282, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(493, 283, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(494, 284, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(495, 285, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(496, 286, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(497, 287, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(498, 288, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(499, 289, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(500, 290, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(501, 291, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(502, 292, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(503, 293, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(504, 294, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(505, 295, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(506, 296, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(507, 297, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(508, 298, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(509, 299, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12'),
(510, 300, '7-2024', 0.00, '2024-09-10 01:59:12', '2024-09-10 01:59:12');

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `product_id`, `user_id`, `created_at`) VALUES
(31, 86, 1, '2023-10-15 12:13:00');

-- --------------------------------------------------------

--
-- Table structure for table `cash_denominations`
--

CREATE TABLE `cash_denominations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `amount` decimal(22,4) NOT NULL,
  `total_count` int(11) NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('close','open') NOT NULL DEFAULT 'open',
  `closed_at` datetime DEFAULT NULL,
  `closing_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `total_card_slips` int(11) NOT NULL DEFAULT 0,
  `total_cheques` int(11) NOT NULL DEFAULT 0,
  `denominations` text DEFAULT NULL,
  `closing_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_register_transactions`
--

CREATE TABLE `cash_register_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_register_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `pay_method` varchar(191) DEFAULT NULL,
  `type` enum('debit','credit') NOT NULL,
  `transaction_type` varchar(191) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `short_code` varchar(191) DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `category_type` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `business_id`, `short_code`, `parent_id`, `created_by`, `category_type`, `description`, `slug`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 'Cons', '1693289792_supermom wi.jpg', 1, NULL, 0, 1, 'product', NULL, NULL, '2023-12-11 01:34:40', '2023-08-28 15:12:37', '2023-12-11 01:34:40'),
(4, 'Ayurvedic', '1693235562_1690341978_Syrup5.jpg', 1, NULL, 0, 1, 'product', NULL, NULL, NULL, '2023-08-28 15:12:42', '2024-07-14 10:31:36'),
(5, 'Orgranic', '1693235566_default.png', 1, 'Orgranic', 0, 1, 'product', NULL, NULL, NULL, '2023-08-29 16:49:48', '2024-07-14 10:31:16'),
(6, 'Gossary', '1693235567_default.png', 1, 'Gossary', 0, 1, 'product', NULL, NULL, NULL, '2023-08-29 16:50:24', '2023-12-13 15:24:18'),
(8, 'personal loan', '1693235565_1690343640_Others1.jpg', 1, 'personal loan', 0, 1, 'product', NULL, NULL, '2023-09-01 16:54:51', '2023-09-01 06:15:55', '2023-09-01 16:54:51'),
(9, 'lunce bill', '1693235565_default.png', 1, 'lunce bill', 0, 1, 'product', NULL, NULL, '2023-09-01 16:54:41', '2023-09-01 06:16:29', '2023-09-01 16:54:41'),
(10, 'Electronics', '1693235565_1690351562_liviton.jpg', 1, 'Electronics', 0, 1, 'product', NULL, NULL, NULL, '2023-09-01 11:35:59', '2023-09-01 11:35:59'),
(11, 'Electric', '1693235564_default.png', 1, 'Electric', 0, 1, 'product', NULL, NULL, NULL, '2023-09-01 11:36:21', '2023-09-01 11:36:21'),
(12, 'Consumer', NULL, 1, NULL, 0, 1, 'product', NULL, NULL, NULL, '2024-01-22 02:49:17', '2024-01-22 02:49:17'),
(13, 'Pharmaceutical', NULL, 1, NULL, 0, 1, 'product', NULL, NULL, NULL, '2024-07-14 10:39:02', '2024-07-14 10:39:02'),
(14, 'Orgranic & Pusti', NULL, 1, NULL, 0, 1, 'product', NULL, NULL, NULL, '2024-07-14 10:39:09', '2024-07-14 10:39:09');

-- --------------------------------------------------------

--
-- Table structure for table `categorizables`
--

CREATE TABLE `categorizables` (
  `category_id` int(11) NOT NULL,
  `categorizable_type` varchar(191) NOT NULL,
  `categorizable_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cb_distribute_lists`
--

CREATE TABLE `cb_distribute_lists` (
  `id` int(191) NOT NULL,
  `month` varchar(191) DEFAULT NULL,
  `year` varchar(191) DEFAULT NULL,
  `date` varchar(191) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cb_distribute_lists`
--

INSERT INTO `cb_distribute_lists` (`id`, `month`, `year`, `date`, `created_at`, `updated_at`) VALUES
(12, '9', '2024', '9-2024', '2024-09-10 01:21:44', '2024-09-10 01:21:44'),
(13, '8', '2024', '8-2024', '2024-09-10 01:43:06', '2024-09-10 01:43:06'),
(14, '7', '2024', '7-2024', '2024-09-10 01:59:12', '2024-09-10 01:59:12');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(191) NOT NULL,
  `supplier_business_name` varchar(191) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `prefix` varchar(191) DEFAULT NULL,
  `first_name` varchar(191) DEFAULT NULL,
  `middle_name` varchar(191) DEFAULT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `contact_id` varchar(191) DEFAULT NULL,
  `contact_status` varchar(191) NOT NULL DEFAULT 'active',
  `tax_number` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `state` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `address_line_1` text DEFAULT NULL,
  `address_line_2` text DEFAULT NULL,
  `zip_code` varchar(191) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobile` varchar(191) NOT NULL,
  `landline` varchar(191) DEFAULT NULL,
  `alternate_number` varchar(191) DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') DEFAULT NULL,
  `credit_limit` decimal(22,4) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `balance` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `total_rp` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `bonus_rp` varchar(20) NOT NULL DEFAULT '0',
  `total_rp_used` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `total_rp_expired` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_address` text DEFAULT NULL,
  `shipping_custom_field_details` longtext DEFAULT NULL,
  `is_export` tinyint(1) NOT NULL DEFAULT 0,
  `export_custom_field_1` varchar(191) DEFAULT NULL,
  `export_custom_field_2` varchar(191) DEFAULT NULL,
  `export_custom_field_3` varchar(191) DEFAULT NULL,
  `export_custom_field_4` varchar(191) DEFAULT NULL,
  `export_custom_field_5` varchar(191) DEFAULT NULL,
  `export_custom_field_6` varchar(191) DEFAULT NULL,
  `position` varchar(191) DEFAULT NULL,
  `child` enum('A','B','NULL') DEFAULT 'NULL',
  `customer_group_id` int(11) DEFAULT NULL,
  `custom_field1` varchar(191) DEFAULT NULL,
  `custom_field2` varchar(191) DEFAULT NULL,
  `custom_field3` varchar(191) DEFAULT NULL,
  `custom_field4` varchar(191) DEFAULT NULL,
  `custom_field5` varchar(191) DEFAULT NULL,
  `custom_field6` varchar(191) DEFAULT NULL,
  `custom_field7` varchar(191) DEFAULT NULL,
  `custom_field8` varchar(191) DEFAULT NULL,
  `custom_field9` varchar(191) DEFAULT NULL,
  `custom_field10` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `e_status` int(11) NOT NULL DEFAULT 1,
  `password` varchar(255) DEFAULT NULL,
  `refered_id` varchar(255) DEFAULT NULL,
  `referel_id` varchar(20) DEFAULT NULL,
  `available_child` varchar(255) DEFAULT NULL,
  `stokist_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts1`
--

CREATE TABLE `contacts1` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(191) NOT NULL,
  `supplier_business_name` varchar(191) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `prefix` varchar(191) DEFAULT NULL,
  `first_name` varchar(191) DEFAULT NULL,
  `middle_name` varchar(191) DEFAULT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `contact_id` varchar(191) DEFAULT NULL,
  `contact_status` varchar(191) NOT NULL DEFAULT 'active',
  `tax_number` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `state` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `address_line_1` text DEFAULT NULL,
  `address_line_2` text DEFAULT NULL,
  `zip_code` varchar(191) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobile` varchar(191) NOT NULL,
  `landline` varchar(191) DEFAULT NULL,
  `alternate_number` varchar(191) DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') DEFAULT NULL,
  `credit_limit` decimal(22,4) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `balance` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `total_rp` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `bonus_rp` varchar(20) NOT NULL DEFAULT '0',
  `total_rp_used` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `total_rp_expired` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_address` text DEFAULT NULL,
  `shipping_custom_field_details` longtext DEFAULT NULL,
  `is_export` tinyint(1) NOT NULL DEFAULT 0,
  `export_custom_field_1` varchar(191) DEFAULT NULL,
  `export_custom_field_2` varchar(191) DEFAULT NULL,
  `export_custom_field_3` varchar(191) DEFAULT NULL,
  `export_custom_field_4` varchar(191) DEFAULT NULL,
  `export_custom_field_5` varchar(191) DEFAULT NULL,
  `export_custom_field_6` varchar(191) DEFAULT NULL,
  `position` varchar(191) DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL,
  `custom_field1` varchar(191) DEFAULT NULL,
  `custom_field2` varchar(191) DEFAULT NULL,
  `custom_field3` varchar(191) DEFAULT NULL,
  `custom_field4` varchar(191) DEFAULT NULL,
  `custom_field5` varchar(191) DEFAULT NULL,
  `custom_field6` varchar(191) DEFAULT NULL,
  `custom_field7` varchar(191) DEFAULT NULL,
  `custom_field8` varchar(191) DEFAULT NULL,
  `custom_field9` varchar(191) DEFAULT NULL,
  `custom_field10` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `e_status` int(11) NOT NULL DEFAULT 1,
  `password` varchar(255) DEFAULT NULL,
  `refered_id` varchar(255) DEFAULT NULL,
  `referel_id` varchar(20) DEFAULT NULL,
  `stokist_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts2`
--

CREATE TABLE `contacts2` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(191) NOT NULL,
  `supplier_business_name` varchar(191) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `prefix` varchar(191) DEFAULT NULL,
  `first_name` varchar(191) DEFAULT NULL,
  `middle_name` varchar(191) DEFAULT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `contact_id` varchar(191) DEFAULT NULL,
  `contact_status` varchar(191) NOT NULL DEFAULT 'active',
  `tax_number` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `state` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `address_line_1` text DEFAULT NULL,
  `address_line_2` text DEFAULT NULL,
  `zip_code` varchar(191) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobile` varchar(191) NOT NULL,
  `landline` varchar(191) DEFAULT NULL,
  `alternate_number` varchar(191) DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') DEFAULT NULL,
  `credit_limit` decimal(22,4) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `balance` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `total_rp` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `bonus_rp` varchar(20) NOT NULL DEFAULT '0',
  `total_rp_used` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `total_rp_expired` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_address` text DEFAULT NULL,
  `shipping_custom_field_details` longtext DEFAULT NULL,
  `is_export` tinyint(1) NOT NULL DEFAULT 0,
  `export_custom_field_1` varchar(191) DEFAULT NULL,
  `export_custom_field_2` varchar(191) DEFAULT NULL,
  `export_custom_field_3` varchar(191) DEFAULT NULL,
  `export_custom_field_4` varchar(191) DEFAULT NULL,
  `export_custom_field_5` varchar(191) DEFAULT NULL,
  `export_custom_field_6` varchar(191) DEFAULT NULL,
  `position` varchar(191) DEFAULT NULL,
  `child` enum('A','B','NULL') DEFAULT 'NULL',
  `customer_group_id` int(11) DEFAULT NULL,
  `custom_field1` varchar(191) DEFAULT NULL,
  `custom_field2` varchar(191) DEFAULT NULL,
  `custom_field3` varchar(191) DEFAULT NULL,
  `custom_field4` varchar(191) DEFAULT NULL,
  `custom_field5` varchar(191) DEFAULT NULL,
  `custom_field6` varchar(191) DEFAULT NULL,
  `custom_field7` varchar(191) DEFAULT NULL,
  `custom_field8` varchar(191) DEFAULT NULL,
  `custom_field9` varchar(191) DEFAULT NULL,
  `custom_field10` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `e_status` int(11) NOT NULL DEFAULT 1,
  `password` varchar(255) DEFAULT NULL,
  `refered_id` varchar(255) DEFAULT NULL,
  `referel_id` varchar(20) DEFAULT NULL,
  `available_child` varchar(255) DEFAULT NULL,
  `assigned_to_users` bigint(20) DEFAULT NULL,
  `user_refered_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts2`
--

INSERT INTO `contacts2` (`id`, `business_id`, `type`, `supplier_business_name`, `name`, `prefix`, `first_name`, `middle_name`, `last_name`, `email`, `image`, `contact_id`, `contact_status`, `tax_number`, `city`, `state`, `country`, `address_line_1`, `address_line_2`, `zip_code`, `dob`, `mobile`, `landline`, `alternate_number`, `pay_term_number`, `pay_term_type`, `credit_limit`, `created_by`, `balance`, `total_rp`, `bonus_rp`, `total_rp_used`, `total_rp_expired`, `is_default`, `shipping_address`, `shipping_custom_field_details`, `is_export`, `export_custom_field_1`, `export_custom_field_2`, `export_custom_field_3`, `export_custom_field_4`, `export_custom_field_5`, `export_custom_field_6`, `position`, `child`, `customer_group_id`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `custom_field5`, `custom_field6`, `custom_field7`, `custom_field8`, `custom_field9`, `custom_field10`, `deleted_at`, `created_at`, `updated_at`, `e_status`, `password`, `refered_id`, `referel_id`, `available_child`, `assigned_to_users`, `user_refered_id`) VALUES
(1, 1, 'customer', NULL, 'Mr Raju Ahmed', 'Mr', 'Raju', 'Ahmed', NULL, 'mdraju2u@gmail.com', NULL, 'trcfpl001', 'active', NULL, NULL, NULL, NULL, 'Vill- Mukterbari, Po- nishatnagor, Ps-Tongi, Dis-Gazipur.', NULL, NULL, NULL, '01976685506', NULL, NULL, NULL, NULL, NULL, 1, 2164.0000, 45, '16', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-13 16:22:23', '2023-12-25 15:30:40', 1, '$2y$10$eFYp5NzbFuntwWaal6pHo.0pVWbksG7aAdfonktYyiHNofF/6BlfS', NULL, 'trcfpl0001', NULL, 19, NULL),
(2, 1, 'customer', NULL, 'Mr Raju Ahmed', 'Mr', 'Raju', 'Ahmed', NULL, 'trcorporationltd@gmail.com', 'img/profile_image_1702463980.png', 'trcfpl0002', 'active', NULL, NULL, NULL, NULL, 'Dhaka', NULL, NULL, NULL, '01766855006', NULL, NULL, NULL, NULL, NULL, 1, 700.0000, 15, '8', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-13 16:26:21', '2023-12-28 03:00:29', 2, '$2y$10$Bnm338MCsURm7L2Vdic3kezNARXBFxxI/O1dfhGccLFZwevzpkt/q', 'trcfpl0001', 'trcfpl0002', 'A', 19, 'trcfpl0001'),
(3, 1, 'customer', NULL, 'Mr Raju Ahmed', 'Mr', 'Raju', 'Ahmed', NULL, 'razuahmed855006@gmail.com', NULL, 'trcfpl0003', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01886699819', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '6', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-13 16:27:56', '2023-12-13 16:27:56', 1, '$2y$10$QXvxv2RuZA6LG7YEOQtQ4.tGBH7WKyxJ8MERXDfUCJndeWoD5q.rq', 'trcfpl0001', 'trcfpl0003', 'B', 19, 'trcfpl0001'),
(4, 1, 'customer', NULL, 'Mst Toma Khatun', 'Mst', 'Toma', 'Khatun', NULL, 'msttomaahmed@gmail.com', NULL, 'trcfpl0004', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01766509344', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '3', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-13 16:35:52', '2023-12-13 16:35:52', 1, '$2y$10$vBYvF9nJBBfUHRgEHeZAge1VTHIaQ4.tLGFOQCGS0jgXEWSTKbcI.', 'trcfpl0002', 'trcfpl0004', 'A', 19, 'trcfpl0001'),
(5, 1, 'customer', NULL, 'Mst Toma Khatun', 'Mst', 'Toma', 'Khatun', NULL, 'ahmedtoma1986@gmail.com', NULL, 'trcfpl0005', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01778668197', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-13 16:37:30', '2023-12-13 16:37:30', 1, '$2y$10$Ci0i7YXELXRkXpgIkQiJnuWFabFbhPgIGWiMb76rFjrUtunx7JmTa', 'trcfpl0002', 'trcfpl0005', 'B', 19, 'trcfpl0002'),
(6, 1, 'customer', NULL, 'Md Ratul Ahmed', 'Md', 'Ratul', 'Ahmed', NULL, 'rajuahmed358681@gmail.com', NULL, 'trcfpl0006', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01795271308', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-13 16:38:36', '2023-12-13 16:38:36', 1, '$2y$10$qk53.Mn4QWSgbXdd02HfrOCfhDXyCOqiNi3I7y1lBsN4pjsKrUssi', 'trcfpl0003', 'trcfpl0006', 'A', 19, 'trcfpl0003'),
(7, 1, 'customer', NULL, 'Md Ratul Ahmed', 'Md', 'Ratul', 'Ahmed', NULL, 'mdratula@gmail.com', NULL, 'trcfpl0007', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01728632007', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-13 16:39:17', '2023-12-13 16:39:17', 1, '$2y$10$gvVtvA9gLuJuFeTYhTXn1evdBRRAGfkCvsNC1BcvQil/9gYGx0HSe', 'trcfpl0003', 'trcfpl0007', 'B', 19, 'trcfpl0003'),
(8, 1, 'customer', NULL, 'Md Abdul Halim', NULL, 'Md', 'Abdul', 'Halim', 'halimuddin582@gmail.com', NULL, 'trcfpl0008', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01330057462', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-14 15:21:55', '2023-12-14 15:21:55', 1, '$2y$10$xOql1vnZ5wbD33qqBX7L1.hT2yrysPVUuih1KN8B7yX5edWLGPk1O', 'trcfpl0004', 'trcfpl0008', 'A', 19, 'trcfpl0004'),
(9, 1, 'supplier', 'Trident Agency Ltd', '', NULL, NULL, NULL, NULL, 'superadmin@gmail.comp', NULL, 'trcfpl0009', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01887922063', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-14 18:49:33', '2023-12-14 18:49:33', 1, '$2y$10$2ln0U1zqWy3WYSTVOmzghuKGyFld6hdrdrs4ZBJqLfWFLfBzP/hMq', 'trcfpl0001', 'trcfpl0009', NULL, 19, 'trcfpl0001'),
(10, 1, 'customer', NULL, 'Md Subrota Sarkar', NULL, 'Md', 'Subrota', 'Sarkar', 'subrota1392@gmail.com', NULL, 'trcfpl0010', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01817001392', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-15 16:25:36', '2023-12-15 16:25:36', 1, '$2y$10$euocFwz7fPbmWBhvV0LY1uzIsmlA4quT98MfpO4Qi3R.X2APBrbbu', 'trcfpl0004', 'trcfpl0010', 'B', 19, 'trcfpl0004'),
(11, 1, 'customer', NULL, 'Md Kovir Hossen', NULL, 'Md', 'Kovir', 'Hossen', 'kovir0144@gmail.com', NULL, 'trcfpl0011', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712500144', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-15 16:28:39', '2023-12-15 16:28:39', 1, '$2y$10$So12b70PIAwmNc8zmPNxgOlIQmjEIE0XoEMWR0HYzuRlZCvW8HD0G', 'trcfpl0005', 'trcfpl0011', 'A', 19, 'trcfpl0005'),
(12, 1, 'customer', NULL, 'Md Nuruzzaman Uddin', NULL, 'Md', 'Nuruzzaman', 'Uddin', 'nuruzzamanhowlader984@gmail.com', NULL, 'trcfpl0012', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01979780984', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-15 16:31:15', '2023-12-15 16:31:15', 1, '$2y$10$T1ulcA943f/JE38pldJXbeVPcAbqAhyRVNdWtts/1rQzfvWyl2R6S', 'trcfpl0005', 'trcfpl0012', 'B', 19, 'trcfpl0005'),
(13, 1, 'customer', NULL, 'Md Sumon Mia', NULL, 'Md', 'Sumon', 'Mia', 'sumonmia713@gail.com', NULL, 'trcfpl0013', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01732770713', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-15 16:32:45', '2023-12-15 16:32:45', 1, '$2y$10$.gz8ztGoZckuYjfKR99BBu5/8d5.CeWsfDX88BUFgLRob5/ztEC/K', 'trcfpl0006', 'trcfpl0013', 'A', 19, 'trcfpl0006'),
(14, 1, 'supplier', 'Ergon Pharmacuticals Ayu', '', NULL, NULL, NULL, NULL, NULL, NULL, 'CO0093', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '02-222294292', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-16 17:25:03', '2023-12-16 17:25:03', 1, '$2y$10$r.Ep.G1ICEQE7dTmxajh2OLjIhtTf.7xy7e8gwanrmuG8rZlBeb3S', NULL, 'trcfpl0014', NULL, NULL, NULL),
(15, 1, 'supplier', 'Dream Consumer Product ltd', '', NULL, NULL, NULL, NULL, NULL, NULL, 'CO0094', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01891750786', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '4', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-16 18:59:14', '2023-12-16 18:59:14', 1, '$2y$10$qFrZryNcULWrUx6LjehV/.2oYG91uDh5sA.YpJzsmUXCEtHTqqCdu', NULL, 'trcfpl0015', NULL, NULL, NULL),
(16, 1, 'supplier', 'AL MODINA CAMICAL COMPANY', '', NULL, NULL, NULL, NULL, NULL, NULL, 'CO0095', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '019755112222', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-16 19:13:18', '2023-12-16 19:13:18', 1, '$2y$10$YIG2gMZ5EweLOqHg8EpF3ucT4sywyr7f1lL9PqyufDncph2iR5iia', NULL, 'trcfpl0016', NULL, NULL, NULL),
(17, 1, 'supplier', 'Actual Green Corporation', '', NULL, NULL, NULL, NULL, NULL, NULL, 'CO0096', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01815325383', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 0, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-16 19:27:01', '2023-12-16 19:27:01', 1, '$2y$10$ikGaDRhDvWICKBZeYFnNhOs/rm/L4L0PQ3/Q9iOsk7atgIKICLEm2', NULL, 'trcfpl0017', NULL, NULL, NULL),
(18, 1, 'supplier', 'City group Of company', '', NULL, NULL, NULL, NULL, NULL, NULL, 'CO0097', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01817097075', NULL, NULL, NULL, NULL, NULL, 1, 0.0000, 15, '0', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-16 19:32:39', '2023-12-17 03:56:02', 1, '$2y$10$eh0m6e9kWOucyLHUJLfGDeBTkcv01pLq.WCfJbJAcX6N1Tk.EvZyy', NULL, 'trcfpl0018', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `country` varchar(100) NOT NULL,
  `currency` varchar(100) NOT NULL,
  `code` varchar(25) NOT NULL,
  `symbol` varchar(25) NOT NULL,
  `thousand_separator` varchar(10) NOT NULL,
  `decimal_separator` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `country`, `currency`, `code`, `symbol`, `thousand_separator`, `decimal_separator`, `created_at`, `updated_at`) VALUES
(1, 'Albania', 'Leke', 'ALL', 'Lek', ',', '.', NULL, NULL),
(2, 'America', 'Dollars', 'USD', '$', ',', '.', NULL, NULL),
(3, 'Afghanistan', 'Afghanis', 'AF', '؋', ',', '.', NULL, NULL),
(4, 'Argentina', 'Pesos', 'ARS', '$', ',', '.', NULL, NULL),
(5, 'Aruba', 'Guilders', 'AWG', 'ƒ', ',', '.', NULL, NULL),
(6, 'Australia', 'Dollars', 'AUD', '$', ',', '.', NULL, NULL),
(7, 'Azerbaijan', 'New Manats', 'AZ', 'ман', ',', '.', NULL, NULL),
(8, 'Bahamas', 'Dollars', 'BSD', '$', ',', '.', NULL, NULL),
(9, 'Barbados', 'Dollars', 'BBD', '$', ',', '.', NULL, NULL),
(10, 'Belarus', 'Rubles', 'BYR', 'p.', ',', '.', NULL, NULL),
(11, 'Belgium', 'Euro', 'EUR', '€', ',', '.', NULL, NULL),
(12, 'Beliz', 'Dollars', 'BZD', 'BZ$', ',', '.', NULL, NULL),
(13, 'Bermuda', 'Dollars', 'BMD', '$', ',', '.', NULL, NULL),
(14, 'Bolivia', 'Bolivianos', 'BOB', '$b', ',', '.', NULL, NULL),
(15, 'Bosnia and Herzegovina', 'Convertible Marka', 'BAM', 'KM', ',', '.', NULL, NULL),
(16, 'Botswana', 'Pula\'s', 'BWP', 'P', ',', '.', NULL, NULL),
(17, 'Bulgaria', 'Leva', 'BG', 'лв', ',', '.', NULL, NULL),
(18, 'Brazil', 'Reais', 'BRL', 'R$', ',', '.', NULL, NULL),
(19, 'Britain [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(20, 'Brunei Darussalam', 'Dollars', 'BND', '$', ',', '.', NULL, NULL),
(21, 'Cambodia', 'Riels', 'KHR', '៛', ',', '.', NULL, NULL),
(22, 'Canada', 'Dollars', 'CAD', '$', ',', '.', NULL, NULL),
(23, 'Cayman Islands', 'Dollars', 'KYD', '$', ',', '.', NULL, NULL),
(24, 'Chile', 'Pesos', 'CLP', '$', ',', '.', NULL, NULL),
(25, 'China', 'Yuan Renminbi', 'CNY', '¥', ',', '.', NULL, NULL),
(26, 'Colombia', 'Pesos', 'COP', '$', ',', '.', NULL, NULL),
(27, 'Costa Rica', 'Colón', 'CRC', '₡', ',', '.', NULL, NULL),
(28, 'Croatia', 'Kuna', 'HRK', 'kn', ',', '.', NULL, NULL),
(29, 'Cuba', 'Pesos', 'CUP', '₱', ',', '.', NULL, NULL),
(30, 'Cyprus', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(31, 'Czech Republic', 'Koruny', 'CZK', 'Kč', ',', '.', NULL, NULL),
(32, 'Denmark', 'Kroner', 'DKK', 'kr', ',', '.', NULL, NULL),
(33, 'Dominican Republic', 'Pesos', 'DOP ', 'RD$', ',', '.', NULL, NULL),
(34, 'East Caribbean', 'Dollars', 'XCD', '$', ',', '.', NULL, NULL),
(35, 'Egypt', 'Pounds', 'EGP', '£', ',', '.', NULL, NULL),
(36, 'El Salvador', 'Colones', 'SVC', '$', ',', '.', NULL, NULL),
(37, 'England [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(38, 'Euro', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(39, 'Falkland Islands', 'Pounds', 'FKP', '£', ',', '.', NULL, NULL),
(40, 'Fiji', 'Dollars', 'FJD', '$', ',', '.', NULL, NULL),
(41, 'France', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(42, 'Ghana', 'Cedis', 'GHS', '¢', ',', '.', NULL, NULL),
(43, 'Gibraltar', 'Pounds', 'GIP', '£', ',', '.', NULL, NULL),
(44, 'Greece', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(45, 'Guatemala', 'Quetzales', 'GTQ', 'Q', ',', '.', NULL, NULL),
(46, 'Guernsey', 'Pounds', 'GGP', '£', ',', '.', NULL, NULL),
(47, 'Guyana', 'Dollars', 'GYD', '$', ',', '.', NULL, NULL),
(48, 'Holland [Netherlands]', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(49, 'Honduras', 'Lempiras', 'HNL', 'L', ',', '.', NULL, NULL),
(50, 'Hong Kong', 'Dollars', 'HKD', '$', ',', '.', NULL, NULL),
(51, 'Hungary', 'Forint', 'HUF', 'Ft', ',', '.', NULL, NULL),
(52, 'Iceland', 'Kronur', 'ISK', 'kr', ',', '.', NULL, NULL),
(53, 'India', 'Rupees', 'INR', '₹', ',', '.', NULL, NULL),
(54, 'Indonesia', 'Rupiahs', 'IDR', 'Rp', ',', '.', NULL, NULL),
(55, 'Iran', 'Rials', 'IRR', '﷼', ',', '.', NULL, NULL),
(56, 'Ireland', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(57, 'Isle of Man', 'Pounds', 'IMP', '£', ',', '.', NULL, NULL),
(58, 'Israel', 'New Shekels', 'ILS', '₪', ',', '.', NULL, NULL),
(59, 'Italy', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(60, 'Jamaica', 'Dollars', 'JMD', 'J$', ',', '.', NULL, NULL),
(61, 'Japan', 'Yen', 'JPY', '¥', ',', '.', NULL, NULL),
(62, 'Jersey', 'Pounds', 'JEP', '£', ',', '.', NULL, NULL),
(63, 'Kazakhstan', 'Tenge', 'KZT', 'лв', ',', '.', NULL, NULL),
(64, 'Korea [North]', 'Won', 'KPW', '₩', ',', '.', NULL, NULL),
(65, 'Korea [South]', 'Won', 'KRW', '₩', ',', '.', NULL, NULL),
(66, 'Kyrgyzstan', 'Soms', 'KGS', 'лв', ',', '.', NULL, NULL),
(67, 'Laos', 'Kips', 'LAK', '₭', ',', '.', NULL, NULL),
(68, 'Latvia', 'Lati', 'LVL', 'Ls', ',', '.', NULL, NULL),
(69, 'Lebanon', 'Pounds', 'LBP', '£', ',', '.', NULL, NULL),
(70, 'Liberia', 'Dollars', 'LRD', '$', ',', '.', NULL, NULL),
(71, 'Liechtenstein', 'Switzerland Francs', 'CHF', 'CHF', ',', '.', NULL, NULL),
(72, 'Lithuania', 'Litai', 'LTL', 'Lt', ',', '.', NULL, NULL),
(73, 'Luxembourg', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(74, 'Macedonia', 'Denars', 'MKD', 'ден', ',', '.', NULL, NULL),
(75, 'Malaysia', 'Ringgits', 'MYR', 'RM', ',', '.', NULL, NULL),
(76, 'Malta', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(77, 'Mauritius', 'Rupees', 'MUR', '₨', ',', '.', NULL, NULL),
(78, 'Mexico', 'Pesos', 'MXN', '$', ',', '.', NULL, NULL),
(79, 'Mongolia', 'Tugriks', 'MNT', '₮', ',', '.', NULL, NULL),
(80, 'Mozambique', 'Meticais', 'MZ', 'MT', ',', '.', NULL, NULL),
(81, 'Namibia', 'Dollars', 'NAD', '$', ',', '.', NULL, NULL),
(82, 'Nepal', 'Rupees', 'NPR', '₨', ',', '.', NULL, NULL),
(83, 'Netherlands Antilles', 'Guilders', 'ANG', 'ƒ', ',', '.', NULL, NULL),
(84, 'Netherlands', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(85, 'New Zealand', 'Dollars', 'NZD', '$', ',', '.', NULL, NULL),
(86, 'Nicaragua', 'Cordobas', 'NIO', 'C$', ',', '.', NULL, NULL),
(87, 'Nigeria', 'Nairas', 'NGN', '₦', ',', '.', NULL, NULL),
(88, 'North Korea', 'Won', 'KPW', '₩', ',', '.', NULL, NULL),
(89, 'Norway', 'Krone', 'NOK', 'kr', ',', '.', NULL, NULL),
(90, 'Oman', 'Rials', 'OMR', '﷼', ',', '.', NULL, NULL),
(91, 'Pakistan', 'Rupees', 'PKR', '₨', ',', '.', NULL, NULL),
(92, 'Panama', 'Balboa', 'PAB', 'B/.', ',', '.', NULL, NULL),
(93, 'Paraguay', 'Guarani', 'PYG', 'Gs', ',', '.', NULL, NULL),
(94, 'Peru', 'Nuevos Soles', 'PE', 'S/.', ',', '.', NULL, NULL),
(95, 'Philippines', 'Pesos', 'PHP', 'Php', ',', '.', NULL, NULL),
(96, 'Poland', 'Zlotych', 'PL', 'zł', ',', '.', NULL, NULL),
(97, 'Qatar', 'Rials', 'QAR', '﷼', ',', '.', NULL, NULL),
(98, 'Romania', 'New Lei', 'RO', 'lei', ',', '.', NULL, NULL),
(99, 'Russia', 'Rubles', 'RUB', 'руб', ',', '.', NULL, NULL),
(100, 'Saint Helena', 'Pounds', 'SHP', '£', ',', '.', NULL, NULL),
(101, 'Saudi Arabia', 'Riyals', 'SAR', '﷼', ',', '.', NULL, NULL),
(102, 'Serbia', 'Dinars', 'RSD', 'Дин.', ',', '.', NULL, NULL),
(103, 'Seychelles', 'Rupees', 'SCR', '₨', ',', '.', NULL, NULL),
(104, 'Singapore', 'Dollars', 'SGD', '$', ',', '.', NULL, NULL),
(105, 'Slovenia', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(106, 'Solomon Islands', 'Dollars', 'SBD', '$', ',', '.', NULL, NULL),
(107, 'Somalia', 'Shillings', 'SOS', 'S', ',', '.', NULL, NULL),
(108, 'South Africa', 'Rand', 'ZAR', 'R', ',', '.', NULL, NULL),
(109, 'South Korea', 'Won', 'KRW', '₩', ',', '.', NULL, NULL),
(110, 'Spain', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(111, 'Sri Lanka', 'Rupees', 'LKR', '₨', ',', '.', NULL, NULL),
(112, 'Sweden', 'Kronor', 'SEK', 'kr', ',', '.', NULL, NULL),
(113, 'Switzerland', 'Francs', 'CHF', 'CHF', ',', '.', NULL, NULL),
(114, 'Suriname', 'Dollars', 'SRD', '$', ',', '.', NULL, NULL),
(115, 'Syria', 'Pounds', 'SYP', '£', ',', '.', NULL, NULL),
(116, 'Taiwan', 'New Dollars', 'TWD', 'NT$', ',', '.', NULL, NULL),
(117, 'Thailand', 'Baht', 'THB', '฿', ',', '.', NULL, NULL),
(118, 'Trinidad and Tobago', 'Dollars', 'TTD', 'TT$', ',', '.', NULL, NULL),
(119, 'Turkey', 'Lira', 'TRY', 'TL', ',', '.', NULL, NULL),
(120, 'Turkey', 'Liras', 'TRL', '£', ',', '.', NULL, NULL),
(121, 'Tuvalu', 'Dollars', 'TVD', '$', ',', '.', NULL, NULL),
(122, 'Ukraine', 'Hryvnia', 'UAH', '₴', ',', '.', NULL, NULL),
(123, 'United Kingdom', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(124, 'United States of America', 'Dollars', 'USD', '$', ',', '.', NULL, NULL),
(125, 'Uruguay', 'Pesos', 'UYU', '$U', ',', '.', NULL, NULL),
(126, 'Uzbekistan', 'Sums', 'UZS', 'лв', ',', '.', NULL, NULL),
(127, 'Vatican City', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(128, 'Venezuela', 'Bolivares Fuertes', 'VEF', 'Bs', ',', '.', NULL, NULL),
(129, 'Vietnam', 'Dong', 'VND', '₫', ',', '.', NULL, NULL),
(130, 'Yemen', 'Rials', 'YER', '﷼', ',', '.', NULL, NULL),
(131, 'Zimbabwe', 'Zimbabwe Dollars', 'ZWD', 'Z$', ',', '.', NULL, NULL),
(132, 'Iraq', 'Iraqi dinar', 'IQD', 'د.ع', ',', '.', NULL, NULL),
(133, 'Kenya', 'Kenyan shilling', 'KES', 'KSh', ',', '.', NULL, NULL),
(134, 'Bangladesh', 'Taka', 'BDT', '৳', ',', '.', NULL, NULL),
(135, 'Algerie', 'Algerian dinar', 'DZD', 'د.ج', ' ', '.', NULL, NULL),
(136, 'United Arab Emirates', 'United Arab Emirates dirham', 'AED', 'د.إ', ',', '.', NULL, NULL),
(137, 'Uganda', 'Uganda shillings', 'UGX', 'USh', ',', '.', NULL, NULL),
(138, 'Tanzania', 'Tanzanian shilling', 'TZS', 'TSh', ',', '.', NULL, NULL),
(139, 'Angola', 'Kwanza', 'AOA', 'Kz', ',', '.', NULL, NULL),
(140, 'Kuwait', 'Kuwaiti dinar', 'KWD', 'KD', ',', '.', NULL, NULL),
(141, 'Bahrain', 'Bahraini dinar', 'BHD', 'BD', ',', '.', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `amount` double(5,2) NOT NULL,
  `price_calculation_type` varchar(191) DEFAULT 'percentage',
  `selling_price_group_id` int(11) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_users`
--

CREATE TABLE `custom_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `referrer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_contact_number` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_address` varchar(255) NOT NULL,
  `stockiest_id` varchar(255) NOT NULL,
  `user_ref_id` varchar(191) DEFAULT NULL,
  `place_user_id` int(191) DEFAULT NULL,
  `placement_side` varchar(15) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `blood_group` varchar(191) DEFAULT NULL,
  `parent_id` int(191) DEFAULT NULL,
  `placement_a` int(191) DEFAULT NULL,
  `placement_b` int(191) DEFAULT NULL,
  `is_IpActive` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_users`
--

INSERT INTO `custom_users` (`id`, `referrer_id`, `customer_name`, `customer_contact_number`, `customer_email`, `customer_address`, `stockiest_id`, `user_ref_id`, `place_user_id`, `placement_side`, `user_id`, `password`, `photo`, `blood_group`, `parent_id`, `placement_a`, `placement_b`, `is_IpActive`, `created_at`, `updated_at`) VALUES
(121, NULL, 'MD RAJU AHMED', '01976685506', 'shawnshikder1996@gmail.com', 'Dhaka, Bangladesh', '1', NULL, NULL, NULL, 'ITRHCL-0001', '$2y$12$mn1THkUrQQSPZT6e6Wg1POZ0tXFNjzKwDL9bjeNTdPPuLK/Lplpau', 'upload/profile/1726495707.jpg', 'B+', NULL, 132, 133, 0, '2024-08-19 08:08:15', '2024-09-26 00:56:51'),
(132, 121, 'MD RAJU AHMED', '01766855006', 'itrhelthcareltd@gmail.com', 'Dhaka', '1', 'stockist-isp-00070.66c88b6371c76', 121, 'A', 'ITRHCL-0002', '$2y$12$P8d1wWHSXYkx25jaqrxSuuCmTVDbPNPsklsT7yzuqn7v2pQqlqipK', NULL, NULL, 121, 134, 135, 1, '2024-08-23 07:15:15', '2024-09-25 10:46:02'),
(133, 121, 'MD JONY', '01711343831', 'jony01711343831@gmail.com', 'Tongi', '1', 'stockist-isp-00054.66c88bbc7e996', 121, 'B', 'ITRHCL-0003', '$2y$12$sbsPCVo9du3ZvAMQfrow3eTE/ziNHJle11MHLyVSLk/ZwCT9Vdv/O', NULL, NULL, 121, 136, 137, 0, '2024-08-23 07:16:44', '2024-08-30 02:49:45'),
(134, 132, 'MST TOMA KHATUN', '01766509344', 'msttomaahmed@gmail.com', 'Tongi', '1', 'stockist-isp-00086.66c88cd206d66', 132, 'A', 'ITRHCL-0004', '$2y$12$WPGTRDxReOcaf3rWJ5UDD.T8rdgp7Dgy7HbnpeEAHkLCzJaAJReZO', NULL, NULL, 132, 308, 309, 0, '2024-08-23 07:21:22', '2024-09-23 22:37:16'),
(135, 132, 'MST TOMA KHATUN', '01778668197', 'ahmedtoma1986@gmail.com', 'Tongi', '1', 'stockist-isp-00055.66c88d1261529', 132, 'B', 'ITRHCL-0005', '$2y$12$21lAbkycnbiev6x3NuaFBOVCodg7M09JCWC6.dprrsblxKqpiagnm', NULL, NULL, 132, 299, 300, 0, '2024-08-23 07:22:26', '2024-09-23 22:31:41'),
(136, 133, 'MD JONY AHMED', '01915800811', 'jony01915800811@gmail.com', 'Tongi', '1', 'stockist-isp-0009.66c88dcf3e529', 133, 'A', 'ITRHCL-0006', '$2y$12$dbLDadKVR5UOPe777f8VW.LG3uxRU/8IDat2/Vvf/PW/lbRDmTdu.', NULL, NULL, 133, 138, NULL, 1, '2024-08-23 07:25:35', '2024-09-25 11:07:37'),
(137, 133, 'MD JONY AHMED', '01837861018', 'jony01837861018@gmail.com', 'Tongi', '1', 'stockist-isp-0002.66c88ede633a5', 133, 'B', 'ITRHCL-0007', '$2y$12$ukq53Fw1FL2eQW/.TwkPJ.ZIA8y4irnHUNag6jaRJjayvD9xSop9a', NULL, NULL, 133, 144, NULL, 1, '2024-08-23 07:30:06', '2024-09-25 11:25:39'),
(138, 136, 'Md Ratul Ahmed', '01963409912', 'trcorporationltd@gmail.com', 'Tongi', '1', 'stockist-isp-00021.66c88f2537a98', 136, 'A', 'ITRHCL-0008', '$2y$12$uny7F..Hb7CV0lNMy6AegeGjPfYq1wou434pAcs0WqbidMNAdGkvi', NULL, NULL, 136, 139, NULL, 0, '2024-08-23 07:31:17', '2024-08-23 07:32:31'),
(139, 138, 'Md Jony Kairul Sumon', '01934248444', 'mdkairul8444@gmail.com', 'Tongi', '1', 'stockist-isp-00058.66c88f6f37f41', 138, 'A', 'ITRHCL-0009', '$2y$12$AHZCY0jvJC68rAn/67gCD.QLig4lLvJOpzpKa.tzku7uxgXT58RF.', 'upload/profile/1726226342.jpg', 'AB+', 138, 141, 140, 0, '2024-08-23 07:32:31', '2024-09-13 05:19:03'),
(140, 139, 'Md Nuruzzaman Howlader', '016243212223', 'nuruzzamanhowlader84@gmail.com', 'Tongi', '1', 'stockist-isp-00035.66c88fbd9480f', 139, 'B', 'ITRHCL-00010', '$2y$12$Mme0G0uHyRAz2daMYwdcjesL.SYLbvsmmwSwxbsp/si79eLT7QLFm', NULL, NULL, 139, 142, NULL, 0, '2024-08-23 07:33:49', '2024-08-23 07:36:19'),
(141, 139, 'Md sumon Mia', '01932770713', 'sumonmia07713@gmailo', 'Tongi', '1', 'stockist-isp-00018.66c88ffebd52a', 139, 'A', 'ITRHCL-00011', '$2y$12$sZFOfLEqMMa6puBmlfT31OfI/s81AYmn1McQxP6QIg07yF1TIUw.S', NULL, NULL, 139, 147, 148, 0, '2024-08-23 07:34:55', '2024-08-23 07:43:43'),
(142, 140, 'SM mahfuzur rahman', '01612299943', 'mahfuz80840@gmail.com', 'Dhaka', '1', 'stockist-isp-00043.66c89052cb981', 140, 'A', 'ITRHCL-00012', '$2y$12$DBYTqE21/ezQjb8LOm7D/O.MKXrdVoqTGR697kYdX9SSnahm.VurK', NULL, NULL, 140, 143, 276, 0, '2024-08-23 07:36:19', '2024-08-24 08:54:16'),
(143, 142, 'Md Abul Basar', '01745996921', 'abulbasar21@gmail.com', 'Tongi', '1', 'stockist-isp-00092.66c8909fe6af7', 142, 'A', 'ITRHCL-00013', '$2y$12$6Gb3EjO0ju3O4rwppoQMEuu9zNP3muCaoXd/gzHWZECpGJ5QbcV8K', NULL, NULL, 142, 158, 160, 0, '2024-08-23 07:37:36', '2024-08-23 09:12:19'),
(144, 137, 'Md Ratul Ahmed', '01795271308', 'mdratul308@gmail.com', 'Tongi', '1', 'stockist-isp-00093.66c890d5ddb0a', 137, 'A', 'ITRHCL-00014', '$2y$12$SWtSpPtnK/danOdTmt18tOwHDY0vl3iickSrRmW2KcPCZ4zk0UjFa', NULL, NULL, 137, 145, NULL, 0, '2024-08-23 07:38:30', '2024-09-24 00:22:51'),
(145, 144, 'Md Sohel Mia', '01965983018', 'spneeloyparvejshohel@gmail.com', 'Bason', '1', 'stockist-isp-00093.66c8910f8b123', 144, 'A', 'ITRHCL-00015', '$2y$12$YZlyWCVNfaV4662eIQood.vt7g5rcI6HHpeuJKxnnv9S.sXdpu7uW', NULL, NULL, 144, 146, 156, 0, '2024-08-23 07:39:27', '2024-09-23 21:40:17'),
(146, 145, 'Md Abdul Halim', '01780273399', 'mdabdulhalim3399@gmail.com', 'gazipur', '1', 'stockist-isp-00010.66c8918980d76', 145, 'A', 'ITRHCL-00016', '$2y$12$7lc7N8yocKxjNZp9Z/U1COwfNCetDCTOlIQfFZcjklAtwH/cMSGv.', NULL, NULL, 145, 238, 250, 0, '2024-08-23 07:41:29', '2024-08-24 02:30:11'),
(147, 141, 'Md sumon Mia', '019875412211', 'itrhealthcareltd0001@gmail.com', 'Tongi', '1', 'stockist-isp-00084.66c891d398d1b', 141, 'A', 'ITRHCL-00017', '$2y$12$GaMCFoeSP4pDG4J58TVT4efSb962BP9RoJYD3K9OjPjAZjEAm3mR2', NULL, NULL, 141, 149, 150, 0, '2024-08-23 07:42:43', '2024-09-24 00:22:07'),
(148, 141, 'Md sumon Mia', '016243212225', 'itrhealthcareltd0002@gmail.com', 'Tongi', '1', 'stockist-isp-00068.66c8920fa4a87', 141, 'B', 'ITRHCL-00018', '$2y$12$aMf/QWw6te2Ivn0g0anpnOtgfbqvPT9sjbp72ZAqYKigWqWdfq9eO', NULL, NULL, 141, 151, 152, 0, '2024-08-23 07:43:43', '2024-08-23 08:22:17'),
(149, 147, 'Md sumon Mia', '0162432122265', 'itrhealthcareltd0003@gmail.com', 'Tongi', '1', 'stockist-isp-00090.66c8924e868af', 147, 'A', 'ITRHCL-00019', '$2y$12$C72unRzTCF7p5QtbEFMMRuC4lrmExyvEHQDqHQksbvB09b7JSVJeq', NULL, NULL, 147, 153, NULL, 0, '2024-08-23 07:44:46', '2024-08-23 08:25:42'),
(150, 147, 'Md sumon Mia', '0162432122266', 'itrhealthcareltd0004@gmail.com', 'Tongi', '1', 'stockist-isp-00071.66c894c613f3a', 147, 'B', 'ITRHCL-00020', '$2y$12$kOY96xpGzlGXiYynp1oiVuBXjArxgsaIiqI95ApI0HXTRez.MnROW', NULL, NULL, 147, 154, NULL, 0, '2024-08-23 07:55:18', '2024-09-23 22:25:18'),
(151, 148, 'Md sumon Mia', '0162432122267', 'itrhealthcareltd0005@gmail.com', 'Tongi', '1', 'stockist-isp-00014.66c89901008c7', 148, 'A', 'ITRHCL-00021', '$2y$12$Moag0KYVyUMC.telRsYmAePBvGJoqmqat7tGOJT75R6kMdJ1MfDKa', NULL, NULL, 148, NULL, NULL, 0, '2024-08-23 08:13:21', '2024-08-23 08:13:21'),
(152, 148, 'Md sumon Mia', '0162432122268', 'itrhealthcareltd0006@gmail.com', 'Tongi', '1', 'stockist-isp-00096.66c89b1935e19', 148, 'B', 'ITRHCL-00022', '$2y$12$vci1BZNMi3DRhLZ/M4niY.oXmK7ZA9oMDC0M0U5T3eGUSKGkeOJFe', NULL, NULL, 148, 155, NULL, 0, '2024-08-23 08:22:17', '2024-08-23 08:29:23'),
(153, 149, 'Mohammad shafiqur Rahman', '01711343832', 'jony017113438312@gmail.com', 'Tongi', '1', 'stockist-isp-00061.66c89be619f31', 149, 'A', 'ITRHCL-00023', '$2y$12$KwrSxyzFd/P3TCEPn7D0be2HidBBjuFJx1iPPRSW4Ko4QTvRkS.WC', NULL, NULL, 149, 174, 175, 0, '2024-08-23 08:25:42', '2024-08-23 10:22:42'),
(154, 150, 'Md Khirul Islam', '01934248445', 'mdkhiruli261@gmail.com', 'Tongi', '1', 'stockist-isp-00094.66c89c33619ab', 150, 'A', 'ITRHCL-00024', '$2y$12$he1YKzA8857m0NSJzEDziuv0KnltWx9vP2PcqGouxh7s0A8EXwEVe', NULL, NULL, 150, 261, 262, 0, '2024-08-23 08:26:59', '2024-09-23 22:29:15'),
(155, 152, 'Md Sumon Mia', '01638309815', 'sumon01932770713@gmail.com', 'Tongi', '1', 'stockist-isp-00065.66c89cc368720', 152, 'A', 'ITRHCL-00025', '$2y$12$Jh7F4ILGlFXwog1vbm9qW.fMP3Vs5MSbFB.3enlr0p3VoiKxV//Uq', NULL, NULL, 152, 181, 182, 0, '2024-08-23 08:29:23', '2024-08-23 10:29:53'),
(156, 145, 'Md Monir hosen', '01830174205', 'monirhosen4205@gmail.com', 'Tongi', '1', 'stockist-isp-00050.66c89e0a7056a', 145, 'B', 'ITRHCL-00026', '$2y$12$fQ4hZs6IROa00NSgb5C6yOeiNzxQ83tFFnbWJsQMXH/sU0i9PAKP6', NULL, NULL, 145, NULL, 157, 0, '2024-08-23 08:34:50', '2024-08-23 08:35:54'),
(157, 145, 'Kazi Golam Saruar', '01600262752', 'kazigolamsaruar52@gmail.com', 'Tongi', '1', 'stockist-isp-00063.66c89e4a0bda6', 156, 'B', 'ITRHCL-00027', '$2y$12$2v9N6iZi9Mju6yDY5yNZDeBL./dtYLsmd1Y7fejSNs8aQQRmTAa3e', NULL, NULL, 156, 172, 173, 0, '2024-08-23 08:35:54', '2024-09-24 00:26:24'),
(158, 143, 'Md Robiul Islam', '01601122592', 'robiulislam8845@gmail.com', 'Dhaka', '1', 'stockist-isp-00025.66c89e8334e75', 143, 'A', 'ITRHCL-00028', '$2y$12$NcS7krIsxQ9G7wFuWOr6W.PzWLPV.Uf9HVOALG5.KeyYk7eKlBsmC', NULL, NULL, 143, 159, NULL, 0, '2024-08-23 08:36:51', '2024-08-23 09:08:50'),
(159, 158, 'Md Jihad Hasan', '01843763015', 'jihadhasan6921@gmail.com', 'Tongi', '1', 'stockist-isp-00068.66c8a601ce7bf', 158, 'A', 'ITRHCL-00029', '$2y$12$4ktCYcS9g6K6bKhkGXDxxOLkSBd3OQYqRWpyfWrZhpfoJcZ6bPNe6', NULL, NULL, 158, 164, 165, 0, '2024-08-23 09:08:50', '2024-08-23 09:16:56'),
(160, 143, 'Mst Salma Begum', '01875076345', 'salmabegum6345@gmail.com', 'Tongi', '1', 'stockist-isp-00032.66c8a6d36c358', 143, 'B', 'ITRHCL-00030', '$2y$12$soQ2z3AFUbZOSH3ygIVDzOgrc/Fj7ZxHhEw.Xu9c2220NEAivx3Zy', NULL, NULL, 143, 161, 162, 0, '2024-08-23 09:12:19', '2024-09-23 21:36:26'),
(161, 160, 'Mst Nazma Akter 2', '01971900241', 'nazmaakter900241@gmail.com', 'Tongi', '1', 'stockist-isp-00061.66c8a71ac87cc', 160, 'A', 'ITRHCL-00031', '$2y$12$eZ6Lp8T29yJHf3Yl1YMOnua5o2UrZpQAnX5wUvL0eRrvKF93mvxKC', NULL, NULL, 160, 199, 214, 0, '2024-08-23 09:13:31', '2024-08-23 11:33:27'),
(162, 160, 'Mst Shahanaz Begum', '01996144631', 'shahanazbegum44631@gmail.com', 'Tongi', '1', 'stockist-isp-00038.66c8a74ff01a2', 160, 'B', 'ITRHCL-00032', '$2y$12$74cqKOnoJm68Xp5IEVoOiO14jm4g1QNbj.22GVIqnoJLa7MUtxq8q', NULL, NULL, 160, 163, 196, 0, '2024-08-23 09:14:24', '2024-08-23 10:55:58'),
(163, 162, 'Mst Nufamone Akter', '01902617508', 'nufamone@gmail.com', 'Tongi', '1', 'stockist-isp-00031.66c8a781a646e', 162, 'A', 'ITRHCL-00033', '$2y$12$BTeWnRHvRhVDAiJAUpYtH.D8NYZ.eFVNSkYySiAN3N2qeLjcQN/xC', NULL, NULL, 162, 191, 197, 0, '2024-08-23 09:15:13', '2024-08-23 10:57:19'),
(164, 159, 'Mst Nazma Begum Lipi', '01714328179', 'nazmabegumlipi8179@gmail.com', 'Tongi', '1', 'stockist-isp-00087.66c8a7b3e32cd', 159, 'A', 'ITRHCL-00034', '$2y$12$XZSO.M5mLm14alD42EB3huVQ6zf4YEPRwZjZM8eoaPfxBh/Nks5gm', NULL, NULL, 159, 222, NULL, 0, '2024-08-23 09:16:04', '2024-08-23 11:53:33'),
(165, 159, 'Mst Rehana Begum', '01753888760', 'rehanabegum8760@gmail.com', 'Tongi', '1', 'stockist-isp-00061.66c8a7e8778f5', 159, 'B', 'ITRHCL-00035', '$2y$12$l0kBlLjLa4howThZHd7tmuPUecn6joq0KCpHnLQbpXjUAdnPPKjZ6', NULL, NULL, 159, NULL, 166, 0, '2024-08-23 09:16:56', '2024-09-23 22:28:27'),
(166, 165, 'Md Manik Mia', '01715047842', 'manikmia47842@gmail.com', 'Tongi', '1', 'stockist-isp-00053.66c8a8298c320', 165, 'B', 'ITRHCL-00036', '$2y$12$eTcJ0MLfukI6W8X14rzYmOgkg61ufHtzm0bc1Kh0cTkX71YqERJxa', NULL, NULL, 165, NULL, 167, 0, '2024-08-23 09:18:01', '2024-08-23 09:19:16'),
(167, 166, 'Ali Haider', '01714893013', 'alihaider3013@gmail.com', 'Tongi', '1', 'stockist-isp-00071.66c8a87468c0f', 166, 'B', 'ITRHCL-00037', '$2y$12$RdXLI5hvRqGVNC/Q/gZvg.mGR6JbG.QgsRCzOgqfJ5yelJpXYhrbK', NULL, NULL, 166, NULL, 168, 0, '2024-08-23 09:19:16', '2024-08-23 09:20:14'),
(168, 167, 'Mst Hasina Begum', '01916403817', 'hasinabegum3817@gmail.com', 'Tongi', '1', 'stockist-isp-00039.66c8a8aea3fab', 167, 'B', 'ITRHCL-00038', '$2y$12$I8HmY2rnA21c76rdqept.ecpjsLPc4UVLbA4wSKAgXY8tIq4QfJ1i', NULL, NULL, 167, NULL, 169, 0, '2024-08-23 09:20:14', '2024-08-23 09:21:16'),
(169, 168, 'Md Hasibur Babu', '019194955167', 'mdhasiburbabu5167@gmail.com', 'Tongi', '1', 'stockist-isp-00052.66c8a8ec492c9', 168, 'B', 'ITRHCL-00039', '$2y$12$S9aU8XQlCuRRxz63UeyuIO32xAAJsmgm18McM4lp5/N.EX9NczCXm', NULL, NULL, 168, NULL, 170, 0, '2024-08-23 09:21:16', '2024-08-23 09:22:12'),
(170, 169, 'Jorna Akter', '01729414168', 'jornaakter4168@gmail.com', 'Tongi', '1', 'stockist-isp-00088.66c8a924133b4', 169, 'B', 'ITRHCL-00040', '$2y$12$5EeSjfDanw8XUtynVq7OtuzqbXs2sgHXaGyf1n1azqzsBFrALLmee', NULL, NULL, 169, NULL, 171, 0, '2024-08-23 09:22:12', '2024-08-23 09:24:24'),
(171, 170, 'Mst Nahar Begum', '01957623918', 'naharbegum3918@gmail.com', 'Tongi', '1', 'stockist-isp-00040.66c8a9a847bbd', 170, 'B', 'ITRHCL-00041', '$2y$12$E07Oq8t1dDVHyfKlEDCGk.dVcRsKhtk/ngwUL.ZR/0tIgVjyMwMCe', NULL, NULL, 170, NULL, 234, 0, '2024-08-23 09:24:24', '2024-08-24 00:13:57'),
(172, 157, 'Mst Taslima Akter', '01746653239', 'taslimaakter3239@gmail.com', 'Tongi', '1', 'stockist-isp-000100.66c8aa1be1be7', 157, 'A', 'ITRHCL-00042', '$2y$12$wHWlxqWUMCK4ACfQj.lgFObpUYgxrqBcF1bfgvZEbZkQQhUmotMtO', NULL, NULL, 157, 176, 177, 0, '2024-08-23 09:26:20', '2024-08-23 10:24:38'),
(173, 157, 'Mst Salma Begum', '01723740728', 'salmabegum0728@gmail.com', 'Tongi', '1', 'stockist-isp-00052.66c8b6e3ddf4b', 157, 'B', 'ITRHCL-00043', '$2y$12$YULzdq/wl7JhORToGNWF7OADKOahAsJQHRaP5oBTIbEKJv.gYtzSS', NULL, NULL, 157, 179, 180, 0, '2024-08-23 10:20:52', '2024-08-23 10:27:43'),
(174, 153, 'Mohammad Shafiqur Rahman', '01716800811', 'jony01711343832@gmail.com', 'Tongi', '1', 'stockist-isp-0005.66c8b71986e70', 153, 'A', 'ITRHCL-00044', '$2y$12$U6F96hFNff6zP9v/T26dyOGFmfdYK5jqDqyE0rEQeqCK16VBEy5ca', NULL, NULL, 153, 235, NULL, 0, '2024-08-23 10:21:45', '2024-08-24 00:15:17'),
(175, 153, 'Mohammad shafiqur Rahman', '01711288438', 'jony017113438310@gmail.com', 'Tongi', '1', 'stockist-isp-00095.66c8b752909a4', 153, 'B', 'ITRHCL-00045', '$2y$12$MnJ.BYvc1tzqUKBSLErPJeplZh3rQxQy3Zhj/ei0KnJUuO57XeCG2', NULL, NULL, 153, NULL, 251, 0, '2024-08-23 10:22:42', '2024-08-24 05:09:42'),
(176, 157, 'Md Ripon Mia', '01709202418', 'riponmia2418@gmail.com', 'Tongi', '1', 'stockist-isp-00055.66c8b78d4fd6e', 172, 'A', 'ITRHCL-00046', '$2y$12$hB.mST8fBMDZZgvOmC9RIOO5EUbsjATYjh5Zx7CtI4ZvuSM1lflg.', NULL, NULL, 172, 293, NULL, 0, '2024-08-23 10:23:41', '2024-08-27 00:05:06'),
(177, 145, 'Ah Biplob', '01944625916', 'ahbiplob5916@gmail.com', 'Tongi', '1', 'stockist-isp-00020.66c8b7c5af846', 172, 'B', 'ITRHCL-00047', '$2y$12$66rHap6TeosK92ayLtEu7OjSmk0Kp15WGtnZRmbd8nwYni2jz1452', NULL, NULL, 172, 178, NULL, 0, '2024-08-23 10:24:38', '2024-08-23 10:25:37'),
(178, 145, 'Md Shofikul Islam', '01645107241', 'mdshofikulislam7241@gmail.com', 'Tongi', '1', 'stockist-isp-00061.66c8b800abea5', 177, 'A', 'ITRHCL-00048', '$2y$12$asvH8hEdroxPO9UtpY4M0e7CfEXlSZp4YJgkwlZOW/WVlnm8yHqSi', NULL, NULL, 177, NULL, NULL, 0, '2024-08-23 10:25:37', '2024-08-23 10:25:37'),
(179, 157, 'Most Sheuli Begum', '01996425870', 'mostsheulibegum5870@gmail.com', 'Tongi', '1', 'stockist-isp-00030.66c8b84976c10', 173, 'A', 'ITRHCL-00049', '$2y$12$2.xiCrsEkF5XnCvijvXche2uND1femk1zE388gcm.nXMxJr9wRspS', NULL, NULL, 173, NULL, NULL, 0, '2024-08-23 10:26:49', '2024-08-23 10:26:49'),
(180, 157, 'Mst Fahima', '01915083933', 'mstfahima3933@gmail.com', 'Tongi', '1', 'stockist-isp-00019.66c8b87fa2087', 173, 'B', 'ITRHCL-00050', '$2y$12$0KVNw5Vqbhu5AMNbnslcZ.40LA43xLnFDaddvvrX7S2v1JH3cJzvW', NULL, NULL, 173, NULL, 295, 0, '2024-08-23 10:27:43', '2024-08-27 00:08:06'),
(181, 155, 'Md sumon Mia', '01732770713', 'sumonmia07710@gmail.com', 'Dhaka', '1', 'stockist-isp-00051.66c8b8c58d799', 155, 'A', 'ITRHCL-00051', '$2y$12$tkPLD8cgHMGA1sgpWm5DsO8R6qNZdaM72NwwHP.eYuCkcBfKN7yzS', NULL, NULL, 155, 183, NULL, 0, '2024-08-23 10:28:53', '2024-08-23 10:30:51'),
(182, 155, 'Md sumon Mia', '01760133087', 'sumonmia077102@gmail.com', 'Dhaka', '1', 'stockist-isp-00049.66c8b9014bbbd', 155, 'B', 'ITRHCL-00052', '$2y$12$yuQ17c3LvkqJwjxSywCNYuwSr1FX.X1xp4BuPHwDwL80/WzC8UMO.', NULL, NULL, 155, NULL, NULL, 0, '2024-08-23 10:29:53', '2024-08-23 10:29:53'),
(183, 181, 'Mst Raziya Akter', '01872781148', 'raziyaakter1148@gmail.com', 'Dhaka', '1', 'stockist-isp-00047.66c8b93adffdb', 181, 'A', 'ITRHCL-00053', '$2y$12$jtTYAPQ/KwjnXfbRUugkA.H.TTI1tWLFx310YPtcfn8TQDkH6Vqbq', NULL, NULL, 181, 184, 188, 0, '2024-08-23 10:30:51', '2024-08-23 10:41:33'),
(184, 183, 'Md yousuf Ali', '01944323340', 'yousufali3340@gmail.com', 'Dhaka', '1', 'stockist-isp-00057.66c8b9704f0ab', 183, 'A', 'ITRHCL-00054', '$2y$12$mQl6rczBkfTgSXmlouavmOt8q9.ApRrIFdjFrzbNbMQoxlIJRUx3G', NULL, NULL, 183, 185, NULL, 0, '2024-08-23 10:31:44', '2024-08-23 10:32:38'),
(185, 183, 'Mst Parvin Akter', '01941436098', 'parvinakter6098@gmail.com', 'Tongi', '1', 'stockist-isp-00055.66c8b9a5ece13', 184, 'A', 'ITRHCL-00055', '$2y$12$T1Tbm4kg4iJp7Bo3nV9.PuSHFINcF004FtmBy/hFCioLiK9jwJVBi', NULL, NULL, 184, 186, 190, 0, '2024-08-23 10:32:38', '2024-08-23 10:43:20'),
(186, 185, 'Mst Firoza Begum 1', '01795259326', 'firozabegum9326@gmail.com', 'Dhaka', '1', 'stockist-isp-00062.66c8b9d85c74d', 185, 'A', 'ITRHCL-00056', '$2y$12$7OrGQlXyV.Nhqiz4SXNvkewCX2sHyu2yEUuBw5zd/gnbqOqvKnRlu', NULL, NULL, 185, 187, NULL, 0, '2024-08-23 10:33:28', '2024-08-23 10:40:37'),
(187, 186, 'Mst Firoza Khatun 2', '01933850332', 'firozabegum0332@gmail.com', 'Dhaka', '1', 'stockist-isp-00039.66c8bb84c9940', 186, 'A', 'ITRHCL-00057', '$2y$12$E9mSk9U59kw.YlILugEgh.1ND/k3WZ1fBZqHXEos2N0gvdPi2MjUy', NULL, NULL, 186, 289, NULL, 0, '2024-08-23 10:40:37', '2024-08-26 02:49:48'),
(188, 183, 'Md Siraj Islam', '01932597599', 'sirajislam7599@gmail.com', 'Dhaka', '1', 'stockist-isp-00059.66c8bbbd84f5e', 183, 'B', 'ITRHCL-00058', '$2y$12$TfiyigW.T6UIQbPUzAgW9.mh1A4BSOqRUBdBI14ZDI5usHtw5rKnO', NULL, NULL, 183, 189, NULL, 0, '2024-08-23 10:41:33', '2024-08-23 10:42:30'),
(189, 183, 'Md Faruq Ahmed', '01620650572', 'faruqahmed0572@gmail.com', 'Dhaka', '1', 'stockist-isp-00037.66c8bbf63f408', 188, 'A', 'ITRHCL-00059', '$2y$12$q1t61E566i7OmiZRWzBrw.kpZvr6.2xatw9TDNmBeiB2kZbYKYFRq', NULL, NULL, 188, NULL, NULL, 0, '2024-08-23 10:42:30', '2024-08-23 10:42:30'),
(190, 185, 'Mst Rahela Begum', '01987833618', 'rahelabegum3618@gmail.com', 'Dhaka', '1', 'stockist-isp-00045.66c8bc27cf60c', 185, 'B', 'ITRHCL-00060', '$2y$12$KUuS9huGmPNQXrZ5HHah7.MRcaf7tIN403zYtXSJoQ9sZYKVogw8K', NULL, NULL, 185, NULL, NULL, 0, '2024-08-23 10:43:20', '2024-08-23 10:43:20'),
(191, 162, 'Nasima Begum', '01853372643', 'nasimabegum2643@gmail.com', 'Tongi', '1', 'stockist-isp-00086.66c8bdff356e0', 163, 'A', 'ITRHCL-00061', '$2y$12$v.1FWFf7pck/XgqML8apZuqqkSwBpQUoKCxbJLjqYIce0xfJvxyzS', NULL, NULL, 163, 192, NULL, 0, '2024-08-23 10:51:11', '2024-08-23 10:52:11'),
(192, 162, 'Halima Begum', '01313621770', 'halimabegum1770@gmail.com', 'Tongi', '1', 'stockist-isp-00037.66c8be3ae3734', 191, 'A', 'ITRHCL-00062', '$2y$12$u7QCSwDC1wm.AflDgDrzQu7Rux1jePcI8SS0mkJ/0WaDPfsyOCSem', NULL, NULL, 191, 193, NULL, 0, '2024-08-23 10:52:11', '2024-08-23 10:53:27'),
(193, 192, 'Sajeda Begum', '01924844829', 'sajedabegum4829@gmail.com', 'Tongi', '1', 'stockist-isp-00046.66c8be86ad764', 192, 'A', 'ITRHCL-00063', '$2y$12$kRPnLhmhT7SWSrKmdV0XheGSFRgXyK8SGz8lxezQdCkHSi9kPDN6u', NULL, NULL, 192, 194, NULL, 0, '2024-08-23 10:53:27', '2024-08-23 10:54:15'),
(194, 162, 'Reshmi Akter', '01875523209', 'reshmiakter209@gmail.com', 'Tongi', '1', 'stockist-isp-0002.66c8beb6daa05', 193, 'A', 'ITRHCL-00064', '$2y$12$HqXNu3U5sF14pQivb1ekneI4LQCtyLSlIXDSqRIvbf5zG.tuFx/Lq', NULL, NULL, 193, 195, NULL, 0, '2024-08-23 10:54:15', '2024-08-23 10:55:06'),
(195, 162, 'Tonny Akter', '01323710160', 'tonnyakter10160@gmail.com', 'Tongi', '1', 'stockist-isp-00027.66c8bee9dc611', 194, 'A', 'ITRHCL-00065', '$2y$12$0EmAR6fKsi2YldJovRrNi.TCpjJD5RXJRjhUJ4cEZNN.V5vTmrIFG', NULL, NULL, 194, 198, NULL, 0, '2024-08-23 10:55:06', '2024-08-23 10:58:15'),
(196, 162, 'Mst Jinu Begum', '01911504019', 'jinubegum4019@gmail.com', 'Tongi', '1', 'stockist-isp-0003.66c8bf1e432c8', 162, 'B', 'ITRHCL-00066', '$2y$12$hdv6YUCOMZEuwTckIMoSHOtaNJPxhoo5nQVWE2NEKnRra5Z5Les46', NULL, NULL, 162, NULL, 275, 0, '2024-08-23 10:55:58', '2024-08-24 08:14:53'),
(197, 163, 'Abu Bokkor Siddiqe', '01902955581', 'siddiqebokkor5581@gmail.com', 'Tongi', '1', 'stockist-isp-00067.66c8bf6f835d1', 163, 'B', 'ITRHCL-00067', '$2y$12$xLFtc4R1isrXBAWZZu.LsOyPXvV2zIz03ZwFvglbPxBYzep.1ZUxW', NULL, NULL, 163, NULL, NULL, 0, '2024-08-23 10:57:19', '2024-08-23 10:57:19'),
(198, 160, 'Begum', '01927126114', 'begum26114@gmail.com', 'Tongi', '1', 'stockist-isp-00084.66c8bfa6b4cdc', 195, 'A', 'ITRHCL-00068', '$2y$12$ZijCn4emWXG9.FDNwQIwKupVrzTsidTHG.gnM/gUdDIDcpApiguvu', NULL, NULL, 195, NULL, NULL, 0, '2024-08-23 10:58:15', '2024-08-23 10:58:15'),
(199, 160, 'Panna Akter', '01929659259', 'pannaakter9259@gmail.com', 'Tongi', '1', 'stockist-isp-000100.66c8bfe554b6f', 161, 'A', 'ITRHCL-00069', '$2y$12$f7MBIlaLSeW5I1LsVlRvLeVxq/RzIkjHoI.qALktTt4Yu0YQKTd7a', NULL, NULL, 161, 200, NULL, 0, '2024-08-23 10:59:17', '2024-08-23 11:00:09'),
(200, 160, 'Parul Begum', '01835555201', 'parulbegum55201@gmail.com', 'Tongi', '1', 'stockist-isp-00046.66c8c018be5c1', 199, 'A', 'ITRHCL-00070', '$2y$12$FTSefFBlgP5PJFnBmHg1QeVEmFg/FifBfKjDnWkxImT4K7GETkC56', NULL, NULL, 199, 201, NULL, 0, '2024-08-23 11:00:09', '2024-08-23 11:01:16'),
(201, 160, 'Morjina Akter Shopna', '01947974464', 'morjinaaktershopna4464@gmail.com', 'Tongi', '1', 'stockist-isp-00054.66c8c05c11504', 200, 'A', 'ITRHCL-00071', '$2y$12$TTPbHmYqTKcE0p4vHz9/j.p0Jhb2haKDG4v6lzLrsBr2vqD.1Z5ea', NULL, NULL, 200, 202, NULL, 0, '2024-08-23 11:01:16', '2024-08-23 11:02:11'),
(202, 160, 'Dr Bakul', '01676181480', 'drbakul1480@gmail.com', 'Tongi', '1', 'stockist-isp-00069.66c8c092e9562', 201, 'A', 'ITRHCL-00072', '$2y$12$NxW64KROnRkSRFS4rIv3OuuUvzwH92fOPZ3/oZZoteSKmSroeW/w2', NULL, NULL, 201, 203, NULL, 0, '2024-08-23 11:02:11', '2024-08-23 11:03:06'),
(203, 160, 'Parvin Akter', '01833710590', 'parvinakter10590@gmail.com', 'Tongi', '1', 'stockist-isp-00042.66c8c0ca09936', 202, 'A', 'ITRHCL-00073', '$2y$12$OPFAKv.qt.SflRSCWU52.eoGI71uD04ywox0nSaQIEcoLc/1L7phG', NULL, NULL, 202, 204, NULL, 0, '2024-08-23 11:03:06', '2024-08-23 11:03:54'),
(204, 160, 'Taniya Begum', '01707959197', 'taniyabegum59197@gmail.com', 'Tongi', '1', 'stockist-isp-00067.66c8c0fa47d0a', 203, 'A', 'ITRHCL-00074', '$2y$12$GH6l5lZJSok1CmHIiT5SDOfuzR3.IIn3IOKnLSwD5OwWw1xZ0P46K', NULL, NULL, 203, 205, NULL, 0, '2024-08-23 11:03:54', '2024-08-23 11:23:44'),
(205, 160, 'Nasima Akter Shuli', '01785002906', 'nasimaaktershuli2906@gmail.com', 'Tongi', '1', 'stockist-isp-00089.66c8c59ff1954', 204, 'A', 'ITRHCL-00075', '$2y$12$qeE6IXFDMM7vgdtKWkuZqeG3l/Rg0Rq.hqdpNTCJp5aNCWEG29.aq', NULL, NULL, 204, 206, 212, 0, '2024-08-23 11:23:44', '2024-08-23 11:31:47'),
(206, 160, 'Mst nazma Begum 3', '01960499617', 'nazmabegum9617@gmail.com', 'Tongi', '1', 'stockist-isp-00034.66c8c5ed59815', 205, 'A', 'ITRHCL-00076', '$2y$12$M9dNhr3eBD34LloV.NRTkeHF4ZGQon/ZRAMmviF4IiADh/Gj6r9uO', NULL, NULL, 205, 207, NULL, 0, '2024-08-23 11:25:01', '2024-08-23 11:26:08'),
(207, 160, 'Mst Tahmina Akter', '01813405438', 'tahminaakter5438@gmail.com', 'Tongi', '1', 'stockist-isp-00068.66c8c62fe63fc', 206, 'A', 'ITRHCL-00077', '$2y$12$b7ZMLhwHVNZxExzhjO727u8c/oCTSDaiKPyC1B9U1rvR6rLy5lxpi', NULL, NULL, 206, 208, 211, 0, '2024-08-23 11:26:08', '2024-08-23 11:30:47'),
(208, 160, 'Mst kohenur Begum', '01934321773', 'kohenurbegum1773@gmail.com', 'Tongi', '1', 'stockist-isp-00051.66c8c66cbb52d', 207, 'A', 'ITRHCL-00078', '$2y$12$s6UAivjKKT2shEEVqetQLeDx1wd8TqyOzjAiiYAhPr8XAXQRqY8Oe', NULL, NULL, 207, 209, NULL, 0, '2024-08-23 11:27:09', '2024-08-23 11:28:42'),
(209, 160, 'Taslima Khanom', '01782277526', 'taslimakhanom7526@gmail.com', 'Tongi', '1', 'stockist-isp-00026.66c8c6c9e7523', 208, 'A', 'ITRHCL-00079', '$2y$12$N5DCOGruS35EBWYvEd24nuUw8kMbSgPvPEQXaAfw.8Gm4rlm5.yQG', NULL, NULL, 208, 210, NULL, 0, '2024-08-23 11:28:42', '2024-08-23 11:29:55'),
(210, 160, 'Salma Akter Bristri', '01997549020', 'salmaakterbristri9020@gmail.com', 'Tongi', '1', 'stockist-isp-00052.66c8c7134a41c', 209, 'A', 'ITRHCL-00080', '$2y$12$N3pL4y.myCQoxb5Xaw.GaeR6iViPqYLYwPirNUAYTyER2VYhivz8u', NULL, NULL, 209, NULL, NULL, 0, '2024-08-23 11:29:55', '2024-08-23 11:29:55'),
(211, 207, 'Rahima Begum', '01922293195', 'rahimabegum93195@gmail.com', 'Tongi', '1', 'stockist-isp-00038.66c8c74794333', 207, 'B', 'ITRHCL-00081', '$2y$12$wr4p.IC6CX4qKgDczAVeae2sXFTdq2EHHwEZfQOQfMdiLlHJ.U8WO', NULL, NULL, 207, NULL, NULL, 0, '2024-08-23 11:30:47', '2024-08-23 11:30:47'),
(212, 205, 'Monoara', '01675622960', 'monoara22960@gmail.com', 'Tongi', '1', 'stockist-isp-00032.66c8c78334b7c', 205, 'B', 'ITRHCL-00082', '$2y$12$BrD2/Y0HCunLW3DiSEUQnOqra2UzS5yiCpAX7jnD3rapddfF04yhm', NULL, NULL, 205, 213, 218, 0, '2024-08-23 11:31:47', '2024-08-23 11:48:37'),
(213, 212, 'Shahanaz Parvin', '01405288001', 'shahanazparvin88001@gmail.com', 'Tongi', '1', 'stockist-isp-00014.66c8c7b35a9ba', 212, 'A', 'ITRHCL-00083', '$2y$12$RS2xHt.wV9jPGrDY7GnduOmkMu/NNelm01rDj83hi8NqbFKmzA5Y2', NULL, NULL, 212, NULL, NULL, 0, '2024-08-23 11:32:35', '2024-08-23 11:32:35'),
(214, 161, 'Bacchu Mia', '01927769213', 'baccumia9213@gmail.com', 'Tongi', '1', 'stockist-isp-00078.66c8c7e787fad', 161, 'B', 'ITRHCL-00084', '$2y$12$uamMPPHaB4ypPiUHWEMwUueSSaMIVDV8xOxdZQFOKgU7JzDJy69QK', NULL, NULL, 161, 215, NULL, 0, '2024-08-23 11:33:27', '2024-08-23 11:40:47'),
(215, 161, 'Halima Begum', '01687763588', 'halimabegum3588@gmail.com', 'Tongi', '1', 'stockist-isp-00046.66c8c99ee1df8', 214, 'A', 'ITRHCL-00085', '$2y$12$S/hfrFZvxSseGSvoKRUjGukvz6E/UHAVeUxHI2sL9fG75ycCEivxq', NULL, NULL, 214, 216, NULL, 0, '2024-08-23 11:40:47', '2024-08-23 11:42:01'),
(216, 161, 'Md Rubel hossen', '01974825646', 'rubelhossen646@gmail.com', 'Tongi', '1', 'stockist-isp-00087.66c8c9e8c2842', 215, 'A', 'ITRHCL-00086', '$2y$12$HdsLxqHisUzONXrAvpiy4uJ.ausHOw/6VUz8.lhAfyr3wg1WdGhBe', NULL, NULL, 215, 217, NULL, 0, '2024-08-23 11:42:01', '2024-08-23 11:45:48'),
(217, 161, 'Salina Akter', '01759238452', 'salinaakter8452@gmail.com', 'Tongi', '1', 'stockist-isp-00057.66c8cacbd086f', 216, 'A', 'ITRHCL-00087', '$2y$12$TFirrxaVJkDuzvXt7CB0XOXFwNPBHF908vF2Doopoyb5Ilq0bKZcu', NULL, NULL, 216, NULL, NULL, 0, '2024-08-23 11:45:48', '2024-08-23 11:45:48'),
(218, 160, 'Ritu Akter', '01761447752', 'rituakter7752@gmail.com', 'Tongi', '1', 'stockist-isp-00031.66c8cb75a07cc', 212, 'B', 'ITRHCL-00088', '$2y$12$Z7ZdbzMndfpYMBHjFgpMf.DQ4nG.fqab2Xi0m95uM.wVe.5X2S95m', NULL, NULL, 212, 219, NULL, 0, '2024-08-23 11:48:37', '2024-08-23 11:49:34'),
(219, 160, 'Shohag', '01618226696', 'shohag6696@gmail.com', 'Tongi', '1', 'stockist-isp-00096.66c8cbae3efdf', 218, 'A', 'ITRHCL-00089', '$2y$12$7q3mhdfTe8HDA928AqBw9uVXZ7IdvpSR.rdXB/57G9mOUXwJL6inW', NULL, NULL, 218, 220, NULL, 0, '2024-08-23 11:49:34', '2024-08-23 11:50:39'),
(220, 160, 'Abdul Jalil', '01726532365', 'abduljalil2365@gmail.com', 'Tongi', '1', 'stockist-isp-00094.66c8cbeef291f', 219, 'A', 'ITRHCL-00090', '$2y$12$iIJMJ7OvZIN1k3aDQpEMy.eBQh.svqy684f9H8ZXCu7S1WeNAw5Y2', NULL, NULL, 219, 221, NULL, 0, '2024-08-23 11:50:39', '2024-08-23 11:52:08'),
(221, 160, 'Hajera Khatun', '01820111923', 'hajerakhatun923@gmail.com', 'Tongi', '1', 'stockist-isp-00065.66c8cc48a4a03', 220, 'A', 'ITRHCL-00091', '$2y$12$VRgFyCZRkydfb8FALhDqguDhRs1Q8RVKoBRd5LZupK.m5Ky9OaOje', NULL, NULL, 220, NULL, NULL, 0, '2024-08-23 11:52:08', '2024-08-23 11:52:08'),
(222, 159, 'Abdul Malek', '01921120140', 'abdulmalek140@gmail.com', 'Tongi', '1', 'stockist-isp-00096.66c8cc9d92dbc', 164, 'A', 'ITRHCL-00092', '$2y$12$gpxNJBoB63IRnAXsKt9qsuMSMr5D84irW0QyD7eAWbmTNXsRwuEv.', NULL, NULL, 164, 223, NULL, 0, '2024-08-23 11:53:33', '2024-08-23 11:56:05'),
(223, 159, 'Ajahar', '01877429937', 'ajahar29937@gmail.com', 'Tongi', '1', 'stockist-isp-00078.66c8cd3589ee6', 222, 'A', 'ITRHCL-00093', '$2y$12$J4HamYpPPiJicheKD2sk0OoKSmpTHjVy6e8XvZGm6dvKJeP6jagVe', NULL, NULL, 222, 224, NULL, 0, '2024-08-23 11:56:05', '2024-08-24 00:04:12'),
(224, 159, 'Dulal Mia', '01927354751', 'dulalmia54751@gmail.com', 'Tongi', '1', 'stockist-isp-00015.66c977dc5f846', 223, 'A', 'ITRHCL-00094', '$2y$12$by2J1tLytb0iMz1DUV5MrekoJS/pTMyuDmL5CbbaCCgGU6Fi7qQd2', NULL, NULL, 223, 225, NULL, 0, '2024-08-24 00:04:12', '2024-08-24 00:05:08'),
(225, 159, 'Fokrul islam', '01818274965', 'fokrulislam4965@gmail.com', 'Tongi', '1', 'stockist-isp-00049.66c9781480d95', 224, 'A', 'ITRHCL-00095', '$2y$12$VLIZuZBDWh1LoFAkB/Ekm.fnrF9DAzeWKkkMc7z8sv/3.WrNxbDe.', NULL, NULL, 224, 226, NULL, 0, '2024-08-24 00:05:08', '2024-08-24 00:06:05'),
(226, 159, 'Nur Nobi Bhuya', '01711105656', 'murnobibhuya5656@gmail.com', 'Tongi', '1', 'stockist-isp-00013.66c9784da3329', 225, 'A', 'ITRHCL-00096', '$2y$12$mTOwgwHglFxipIaqr4TCJeFRZ0rh2qRbKaBpqEDWwb5A9MVBji2BG', NULL, NULL, 225, 227, NULL, 0, '2024-08-24 00:06:05', '2024-08-24 00:07:01'),
(227, 159, 'Rofiqul Islam', '01869233082', 'rafiqulislam3082@gmail.com', 'Tongi', '1', 'stockist-isp-00065.66c97884db9e4', 226, 'A', 'ITRHCL-00097', '$2y$12$.m1g.oiP/XidyfhdGRfgfOvuXfh7sfTgXsyevbUBmuKmCFxkK.OpO', NULL, NULL, 226, 228, NULL, 0, '2024-08-24 00:07:01', '2024-08-24 00:08:04'),
(228, 159, 'Saymun Islam', '01879378729', 'saymunislam8729@gmail.com', 'Tongi', '1', 'stockist-isp-00095.66c978c480ac3', 227, 'A', 'ITRHCL-00098', '$2y$12$Sn7LjPPBXXKRvDrV1MZQUehbwUj.anG0mjn55yB9.mEncxrDrXZ6.', NULL, NULL, 227, 229, NULL, 0, '2024-08-24 00:08:04', '2024-08-24 00:09:22'),
(229, 159, 'Raihan Mirdra', '01568278717', 'raihan278717@gmail.com', 'Tongi', '1', 'stockist-isp-0003.66c9791274cac', 228, 'A', 'ITRHCL-00099', '$2y$12$y0RUPEIyCjtlkHuAjZzQgubIi4JAMfzi/OVMNVyFd.k4tnxRwaue6', NULL, NULL, 228, 230, NULL, 0, '2024-08-24 00:09:22', '2024-08-24 00:10:16'),
(230, 159, 'Azad Mia', '01946714097', 'azadmia14097@gmail.com', 'Tongi', '1', 'stockist-isp-00022.66c9794806425', 229, 'A', 'ITRHCL-000100', '$2y$12$gH33LdR9xoNpj7wOLNYW0eKwyeNv/ru8rqWlhIxkBZ9lV8TeZOiwq', NULL, NULL, 229, 231, NULL, 0, '2024-08-24 00:10:16', '2024-08-24 00:11:01'),
(231, 159, 'Jorina Akter Jerin', '01604104353', 'jorinaakterjerin4353@gmail.com', 'Tongi', '1', 'stockist-isp-00042.66c97974e6087', 230, 'A', 'ITRHCL-000101', '$2y$12$vgYwCg1f4f6/6DP1pWJIre9JDS8DbZ39WJsi2rdHhvBRTpRAfdi5e', NULL, NULL, 230, 232, NULL, 0, '2024-08-24 00:11:01', '2024-08-24 00:12:09'),
(232, 159, 'Bablu Hosen', '01846394120', 'babluhosen4120@gmail.com', 'Tongi', '1', 'stockist-isp-00054.66c979b979fa1', 231, 'A', 'ITRHCL-000102', '$2y$12$VN.OeQ1YCntyprmHA9aBOOnY/65q8QGqd4EdkZkDZxYuxQwleG1Z6', NULL, NULL, 231, 233, NULL, 0, '2024-08-24 00:12:09', '2024-08-24 00:12:55'),
(233, 159, 'Kovir Hosen', '01611583200', 'kovirhoen3200@gmail.com', 'Tongi', '1', 'stockist-isp-00054.66c979e6b6d40', 232, 'A', 'ITRHCL-000103', '$2y$12$2BsvPus77PjB5hCIH2soI.D4JW00ikRpaIC4gh2HJY3k4BO4GhdN.', NULL, NULL, 232, 272, NULL, 0, '2024-08-24 00:12:55', '2024-08-24 08:08:42'),
(234, 159, 'Dr Ikbal Hossen', '01848338516', 'ikbalhossen338516@gmail.com', 'Tongi', '1', 'stockist-isp-0005.66c97a2581071', 171, 'B', 'ITRHCL-000104', '$2y$12$XEn9/kbJ2no8bnyQ5qM4XOl4D9Whqy/M8JsNOGnkkdwLtH.XDlY1G', NULL, NULL, 171, NULL, 267, 0, '2024-08-24 00:13:57', '2024-08-24 07:50:10'),
(235, 174, 'Syefunnahar', '01910091000', 'jony0171134383123@gmail.com', 'Tongi', '1', 'stockist-isp-00076.66c97a753cffe', 174, 'A', 'ITRHCL-000105', '$2y$12$eaF6IaZ0Yt8rB/3rbOJRC.p540rnLdY.MxYa0r8dD6P8lZYDLkw7e', NULL, NULL, 174, 236, 237, 0, '2024-08-24 00:15:17', '2024-08-24 00:17:47'),
(236, 235, 'Syefunnahar', '01910091001', 'jony017113438313@gmail.com', 'Tongi', '1', 'stockist-isp-00078.66c97ada273c8', 235, 'A', 'ITRHCL-000106', '$2y$12$U91VrmdqwDY0CfcYqlAKbOuv0WuVGhtS7tbRuEyUW5LYR7ypKVX2i', NULL, NULL, 235, 239, NULL, 0, '2024-08-24 00:16:58', '2024-08-24 00:20:02'),
(237, 235, 'Syefunnahar', '019100910001', 'jony017113438314@gmail.com', 'Tongi', '1', 'stockist-isp-00018.66c97b0b3bce2', 235, 'B', 'ITRHCL-000107', '$2y$12$j/0QNxd84L6uIgb7LCvCbu6RH2d9wJOfe9SvtpqLFPUWF/IG.SFC6', NULL, NULL, 235, NULL, NULL, 0, '2024-08-24 00:17:47', '2024-08-24 00:17:47'),
(238, 146, 'Shahar Mamun', '01980485557', 'msmamun5557@gmail.com', 'gazipur', '1', 'stockist-isp-00028.66c97b3f46edc', 146, 'A', 'ITRHCL-000108', '$2y$12$AYxRLL1RfoYkvBs/X9YXmOTol22OBOZWGSOyL1ukWHGJdMAvATy9S', NULL, NULL, 146, NULL, NULL, 0, '2024-08-24 00:18:39', '2024-09-24 00:25:49'),
(239, 236, 'Md ali Hossen', '01740287783', 'mah287783@gmail.com', 'Tongi', '1', 'stockist-isp-00018.66c97b9292ad8', 236, 'A', 'ITRHCL-000109', '$2y$12$v8c6EN8ORDu79EIYMR2H2.kFLJAnd88T9fM2dqgEzMdydAoWFOvyO', NULL, NULL, 236, 240, 241, 0, '2024-08-24 00:20:02', '2024-08-24 00:25:56'),
(240, 239, 'Raufa Akter', '01925941282', 'raufa941282@gmail.com', 'Tongi', '1', 'stockist-isp-0007.66c97bd0762c2', 239, 'A', 'ITRHCL-000110', '$2y$12$syAOo9HQgRP41gxcKNSkfO7mgYNbbb/clNq9UgYgpzEo4rcPirXaW', NULL, NULL, 239, 242, NULL, 0, '2024-08-24 00:21:04', '2024-08-24 00:27:03'),
(241, 239, 'Samriti akter', '01816390236', 'smriti390236@gmail.com', 'Tongi', '1', 'stockist-isp-00084.66c97cf4002b4', 239, 'B', 'ITRHCL-000111', '$2y$12$N2rpGmpwJPn2gRGnNTyeUeVf9asxuoJBOdxwKV8jF34JASf1Rq4by', NULL, NULL, 239, NULL, 244, 0, '2024-08-24 00:25:56', '2024-08-24 00:29:12'),
(242, 239, 'Sonya', '01889706946', 'sonya706946@gmail.com', 'Tongi', '1', 'stockist-isp-00013.66c97d3789208', 240, 'A', 'ITRHCL-000112', '$2y$12$G9cp.ve9fccMFY4WcOt3mOC5evvVFmoMvNI0DCx/gYdKLi18aV3nm', NULL, NULL, 240, 243, NULL, 0, '2024-08-24 00:27:03', '2024-08-24 00:28:06'),
(243, 239, 'Bity Khatun', '01902154648', 'bity154648@gmail.com', 'Tongi', '1', 'stockist-isp-00049.66c97d7696a97', 242, 'A', 'ITRHCL-000113', '$2y$12$.M.XqLQoOAJt7RAxvMkNnOYbPwcTifPI7XriurLYWaRqxn8fk6P/q', NULL, NULL, 242, 284, NULL, 0, '2024-08-24 00:28:06', '2024-08-26 02:29:14'),
(244, 239, 'Sumon Jyoti Barua', '01815590518', 'sumon590518@gmail.com', 'Tongi', '1', 'stockist-isp-00055.66c97db7cbb6f', 241, 'B', 'ITRHCL-000114', '$2y$12$0SjE1uV7kupCpdbTnnYy0uyuZZtwDTlX6xx00opnSpB1dR9Kc1K2q', NULL, NULL, 241, NULL, 245, 0, '2024-08-24 00:29:12', '2024-08-24 00:30:45'),
(245, 239, 'Md Nazrul Islam', '01991991982', 'nazrul991882@gmail.com', 'Tongi', '1', 'stockist-isp-00011.66c97e14e1249', 244, 'B', 'ITRHCL-000115', '$2y$12$y3ffKs28g0itfjcyTKAYgOt8tND3AzNJHvzoeM/9xlV/1YvRWztf6', NULL, NULL, 244, NULL, 246, 0, '2024-08-24 00:30:45', '2024-08-24 00:31:32'),
(246, 239, 'Mir Altaf Uddin', '01776783028', 'altaf783028@gmail.com', 'Tongi', '1', 'stockist-isp-00053.66c97e448b265', 245, 'B', 'ITRHCL-000116', '$2y$12$o1WgYzxrWbwKXdIbOWOibeCtVkKwYs1R9rljaNXMJ19bZOeoEuYge', NULL, NULL, 245, NULL, 247, 0, '2024-08-24 00:31:32', '2024-08-24 00:32:20'),
(247, 239, 'Md Selim Hosen', '01711902159', 'selim902159@gmail.com', 'Tongi', '1', 'stockist-isp-00044.66c97e746febe', 246, 'B', 'ITRHCL-000117', '$2y$12$S6Sh0sv5tbN9IMe6ZLevyOEI4kFcIY2B3F91GeViPtU/f54lDZ5KC', NULL, NULL, 246, NULL, 248, 0, '2024-08-24 00:32:20', '2024-08-24 00:33:05'),
(248, 239, 'Belayet Hossain Patwary', '01720056014', 'belayet56014@gmail.com', 'Tongi', '1', 'stockist-isp-00069.66c97ea0ccb44', 247, 'B', 'ITRHCL-000118', '$2y$12$Bw87dleKSn.sLYHYCsKd6.5CCE2iBpPJCfJj1NI4TOXnioqKrDvoC', NULL, NULL, 247, NULL, 249, 0, '2024-08-24 00:33:05', '2024-08-24 00:33:53'),
(249, 239, 'Md Monir Uddin', '01936083477', 'monir83477@gmail.com', 'Tongi', '1', 'stockist-isp-00047.66c97ed13e7bc', 248, 'B', 'ITRHCL-000119', '$2y$12$r.fBvEkiAeWM6MjcgJVQTepAgkZcOl4QEUi6yq0wnlC43lMFlYIBi', NULL, NULL, 248, NULL, NULL, 0, '2024-08-24 00:33:53', '2024-08-24 00:33:53'),
(250, 146, 'Md Abdur Rahman', '01909408351', 'abdurrahman8351@gmail.com', 'vipus', '1', 'stockist-isp-00052.66c99a137853a', 146, 'B', 'ITRHCL-000120', '$2y$12$QsX2k6AIG.WoP.qSIir7GOoSiBsjhssrKDrrcPggNfi.v8m0XV/eO', NULL, NULL, 146, NULL, NULL, 0, '2024-08-24 02:30:11', '2024-08-24 02:30:11'),
(251, 175, 'Towfiq Hasan', '017112884389', 'towfiq01711288438@gmail.com', 'Tongi', '1', 'stockist-isp-00084.66c9bf75aff8a', 175, 'B', 'ITRHCL-000121', '$2y$12$HhXEeq.s/WzraDBAngqjk.4sCrGP3iGKTlzPCkQqQQ3ntiR9w4/Ve', NULL, NULL, 175, NULL, NULL, 0, '2024-08-24 05:09:42', '2024-08-24 05:09:42'),
(252, 251, 'Towfiq Hasan', '017112884382', 'towfiq01711288439@gmail.com', 'Tongi', '1', 'stockist-isp-00050.66c9bfd569e24', 251, NULL, 'ITRHCL-000122', '$2y$12$ZqQDWE4gbhZwExDKCIhcrOHMGSpOYFE.fckpaQmt8oSDR1q3kHG7e', NULL, NULL, 251, NULL, NULL, 0, '2024-08-24 05:11:17', '2024-08-24 05:11:17'),
(253, 251, 'Towfiq Hasan', '017112884381', 'towfiq017112884392@gmail.com', 'Tongi', '1', 'stockist-isp-00088.66c9c01372be6', 251, NULL, 'ITRHCL-000123', '$2y$12$PjNLHCo7qLekV2hqTf00AuEYPWXUKzTTeA8k5ZyHSoGx5kXXR1x4C', NULL, NULL, 251, NULL, 254, 0, '2024-08-24 05:12:19', '2024-08-24 05:15:43'),
(254, 251, 'Md Maruf sikder', '01404843885', 'msikder1989bd@gmail.com', 'Ghasa', '1', 'stockist-isp-00098.66c9c0df78fc4', 253, 'B', 'ITRHCL-000124', '$2y$12$HmuGK4CB13eKk1RFUSKEkeLZFpR34YhEGk3aOw5fwgZoY8JT8b64W', NULL, NULL, 253, 255, 256, 0, '2024-08-24 05:15:43', '2024-08-24 05:20:20'),
(255, 254, 'Jannatul Ferdows', '01402224870', 'j224870@gmail.com', 'Ghasa', '1', 'stockist-isp-00069.66c9c19b13b2f', 254, 'A', 'ITRHCL-000125', '$2y$12$mZhrt5/F2LxnowdkloqlDulguzdbGWs4jxX9saFCgVzPtmCHYxKnS', NULL, NULL, 254, 260, NULL, 0, '2024-08-24 05:18:51', '2024-09-23 22:30:24'),
(256, 254, 'Sharmin Akter', '01770936970', 's936970@gmail.com', 'Ghasa', '1', 'stockist-isp-00039.66c9c1f49d300', 254, 'B', 'ITRHCL-000126', '$2y$12$AeQDv5jodU.UETbIY8PqgOE1NzZRUTkq/BhsewCTHdtTWkw1ZGpZy', NULL, NULL, 254, NULL, 257, 0, '2024-08-24 05:20:20', '2024-08-24 05:24:49'),
(257, 251, 'shamppa saha', '01673470598', 'shomppashaha@gmail.com', 'Tongi', '1', 'stockist-isp-00036.66c9c300bad72', 256, 'B', 'ITRHCL-000127', '$2y$12$m1gdYCb/H7lI7ShqWblnS.kqDSsJKAIPLQNo4jtkqZ9QHDLXnSvHe', NULL, NULL, 256, 258, 259, 0, '2024-08-24 05:24:49', '2024-08-24 05:31:46'),
(258, 257, 'Joydeb saha', '01970449152', 'j449152@gmail.com', 'Tongi', '1', 'stockist-isp-00088.66c9c44a30215', 257, 'A', 'ITRHCL-000128', '$2y$12$91XouIlb7m1VgTp2p8GSZOJIKy3f9jhoGFsazf5sy3/EQPeoUaONy', NULL, NULL, 257, NULL, NULL, 0, '2024-08-24 05:30:18', '2024-08-24 05:30:18'),
(259, 257, 'Tonny Saha', '01640717400', 't017400@gmail.com', 'Tongi', '1', 'stockist-isp-00081.66c9c4a1e54de', 257, 'B', 'ITRHCL-000129', '$2y$12$7HnNBS18JK6zdAmtsoBz1.X/ctEWa8cMSrl7ynBUbJtI6.mRdBLt.', NULL, NULL, 257, NULL, NULL, 0, '2024-08-24 05:31:46', '2024-08-24 05:31:46'),
(260, 254, 'Md Shidar Rahman', '01743594195', 'shidarrahman4195@gmail.com', 'Ghasa', '1', 'stockist-isp-00013.66c9c623826df', 255, 'A', 'ITRHCL-000130', '$2y$12$6MPVDwIUOJex7Uj2Cj7dEOj9X6hRfRRkq3s/eLV4PaCCcTy2aJQEy', NULL, NULL, 255, NULL, NULL, 0, '2024-08-24 05:38:11', '2024-08-24 05:38:11'),
(261, 154, 'md Kairul Islam', '019342484449', 'kairulislam44@gmail.com', 'gazipur', '1', 'stockist-isp-00049.66c9cd2f6cac0', 154, 'A', 'ITRHCL-000131', '$2y$12$mZcAwBT6a8jqK7ZBgNfFX.gzFa3wKz86tWVm2st05Rvjwvw2zZx2a', NULL, NULL, 154, 263, 264, 0, '2024-08-24 06:08:15', '2024-08-24 06:12:13'),
(262, 154, 'Md Khirul Islam', '019342484441', 'kairulislam441@gmail.com', 'gazipur', '1', 'stockist-isp-00058.66c9cd81355a8', 154, 'B', 'ITRHCL-000132', '$2y$12$jAPJdunLDFNClNV3Wmlq5uoG4WLUVwne09VZBx2bfxG/LVl3tdn7a', NULL, NULL, 154, 265, 266, 0, '2024-08-24 06:09:37', '2024-08-24 06:15:17'),
(263, 154, 'Md Khirul Islam', '019342484442', 'kairulislam442@gmail.com', 'gazipur', '1', 'stockist-isp-00063.66c9cdda827e6', 261, 'A', 'ITRHCL-000133', '$2y$12$ht/prpR90PGwCFopel0OK.xAbdNLq054EVcjwwlCTTU5Zm9x/v9oy', NULL, NULL, 261, 279, NULL, 0, '2024-08-24 06:11:06', '2024-08-25 06:32:05'),
(264, 154, 'Md Khirul Islam', '019342484443', 'kairulislam443@gmail.com', 'gazipur', '1', 'stockist-isp-00042.66c9ce1ce883c', 261, 'B', 'ITRHCL-000134', '$2y$12$RyPqx9YnQbGRUTTf29hNqOlXP9CskjiFxQzPLWakuXlgMfw5.247C', NULL, NULL, 261, 288, NULL, 0, '2024-08-24 06:12:13', '2024-08-26 02:41:40'),
(265, 154, 'Md Khirul Islam', '019342484444', 'kairulislam444@gmail.com', 'gazipur', '1', 'stockist-isp-00070.66c9ce591ec9b', 262, 'A', 'ITRHCL-000135', '$2y$12$Am9N.lp8Ue0qfQcrlu4NzezN03X.9DTMHATP.Z2RFAKMoeRiEtooq', NULL, NULL, 262, NULL, NULL, 0, '2024-08-24 06:13:13', '2024-08-24 06:13:13'),
(266, 154, 'Md Khirul Islam', '019342484445', 'kairulislam445@gmail.com', 'gazipur', '1', 'stockist-isp-00020.66c9ced4d0c50', 262, 'B', 'ITRHCL-000136', '$2y$12$iBJV2boI2U3YlFV55ByL/OtkBtmumzXaaIMKoFefPMXS.w9SmetRO', NULL, NULL, 262, NULL, 283, 0, '2024-08-24 06:15:17', '2024-08-25 06:44:56'),
(267, 159, 'Sakib hossen', '01989670786', 'sakibhossen786@gmail.com', 'Tongi', '1', 'stockist-isp-00098.66c9e511e22f6', 234, 'B', 'ITRHCL-000137', '$2y$12$BBDeG/3Zoq9w6/fV6mkpOuzX8PoG7bANjnUaBhcSdN86E066/f/Ya', NULL, NULL, 234, NULL, 268, 0, '2024-08-24 07:50:10', '2024-08-24 07:52:18'),
(268, 159, 'Anjuman', '01973735656', 'anjuman@gmail.com', 'Tongi', '1', 'stockist-isp-00054.66c9e591ae6dc', 267, 'B', 'ITRHCL-000138', '$2y$12$0dz5EjqJoMeFgV9aXzaHveT2xiohZSj6TPPBA14NUyhYvVM.NnNLm', NULL, NULL, 267, NULL, 269, 0, '2024-08-24 07:52:18', '2024-08-24 07:54:54'),
(269, 159, 'Hafijur Rahman', '01744840407', 'hafijurrahman@gmail.com', 'Tongi', '1', 'stockist-isp-00072.66c9e62e2bbf5', 268, 'B', 'ITRHCL-000139', '$2y$12$6i9Toda9kKcwFfWaObK1aeJy4WZjQHSBlQ/yrYiNIojUTHxQ.dORa', NULL, NULL, 268, NULL, 270, 0, '2024-08-24 07:54:54', '2024-08-24 08:02:54'),
(270, 159, 'Md Saiful Islam', '01762163576', 'saifulislam576@gmail.com', 'Tongi', '1', 'stockist-isp-00076.66c9e80e6ec1a', 269, 'B', 'ITRHCL-000140', '$2y$12$8qR4YNXYRPPAYukUKuM.SOum.XIgmVjkeCnOkU6ZhAdVI6TUOEBB6', NULL, NULL, 269, NULL, 271, 0, '2024-08-24 08:02:54', '2024-08-24 08:05:09'),
(271, 159, 'Md Shamsuuddin Mia', '01711150198', 'samsuuddin198@gmail.com', 'Tongi', '1', 'stockist-isp-00082.66c9e89501ee2', 270, 'B', 'ITRHCL-000141', '$2y$12$DENvQGaluwqP6NQRXahtAOirUfQNn05EShbuw7ygg3XZTk07beMrq', NULL, NULL, 270, NULL, NULL, 0, '2024-08-24 08:05:09', '2024-08-24 08:05:09'),
(272, 159, 'Md Nazrul islam Bhuya', '01686873062', 'nazrulislam3062@gmail.com', 'Tongi', '1', 'stockist-isp-00020.66c9e969abd94', 233, 'A', 'ITRHCL-000142', '$2y$12$lkcQd7zsU0tqnwMh5OxxoeHw0ZFgtpfRVf6tCfvp.g7UrzyTdjN5K', NULL, NULL, 233, 273, NULL, 0, '2024-08-24 08:08:42', '2024-08-24 08:10:07'),
(273, 121, 'Md faruk', '01796999374', 'faruk9374@gmail.com', 'ITRHCL-0009', '1', 'stockist-isp-00040.66c9e9beef4c5', 272, 'A', 'ITRHCL-000143', '$2y$12$oNEPXQhGMwTccXVRL8X/Eu1uax2bi21yIbm8QQleIkgcpmfhHnkMa', NULL, NULL, 272, 274, NULL, 0, '2024-08-24 08:10:07', '2024-08-24 08:11:17'),
(274, 159, 'Abul Hossen', '01612664474', 'abulhossen4474@gmail.com', 'Tongi', '1', 'stockist-isp-00087.66c9ea05071bb', 273, 'A', 'ITRHCL-000144', '$2y$12$CJb0SLklavCQU.Ax5.7GEelb8T7skHUHmrDYQnxVafNZZTx3ZdcbW', NULL, NULL, 273, 291, NULL, 0, '2024-08-24 08:11:17', '2024-08-26 21:58:03'),
(275, 160, 'Sajoni Begum', '01996142451', 'sajonibegum@gmail.com', 'Tongi', '1', 'stockist-isp-00078.66c9eadd9bd21', 196, 'B', 'ITRHCL-000145', '$2y$12$ghsatb3B8oGiB1Nke1EflOqWwaZfvFqfFPMRgq3ht4dfInWPCCtna', NULL, NULL, 196, NULL, 292, 0, '2024-08-24 08:14:53', '2024-08-26 21:59:12'),
(276, 142, 'Md Abdul Mannan', '01723437964', 'jibon964@gmail.com', 'Dhaka', '1', 'stockist-isp-00057.66c9f4180d30d', 142, 'B', 'ITRHCL-000146', '$2y$12$PIGwHVzR3BgZvECiiMJpPukXFHzq7HgLgiBKOaLfirxZqwmTr/f5C', NULL, NULL, 142, NULL, 277, 0, '2024-08-24 08:54:16', '2024-08-24 08:57:18'),
(277, 276, 'Md jillur Rahman', '01961468972', 'jillurrahman@gmail.com', 'Tongi', '1', 'stockist-isp-00084.66c9f4cea7c15', 276, 'B', 'ITRHCL-000147', '$2y$12$xUS/ckkQDSHqvC3SfQbmPuD1n4RxzivsFCeGyvB0jJgCIno9Uy77.', NULL, NULL, 276, NULL, 278, 0, '2024-08-24 08:57:18', '2024-08-24 08:58:30'),
(278, 276, 'Md Taher Mia', '01829242028', 'tahermia@gmail.com', 'Tongi', '1', 'stockist-isp-00025.66c9f516453a0', 277, 'B', 'ITRHCL-000148', '$2y$12$tHqo.DtANZfDc.b3MQOCEeapMUO.KS5h5lgw7Kzr0PA4EQ.HpMjI2', NULL, NULL, 277, NULL, NULL, 0, '2024-08-24 08:58:30', '2024-08-24 08:58:30'),
(279, 263, 'Md Akash ahmed', '01931461154', 'akashbd1980@gmail.com', 'Dhaka', '1', 'stockist-isp-00089.66cb244559ba1', 263, 'A', 'ITRHCL-000149', '$2y$12$F0rQk2CZ6eU1ynq0SFF3Q.AokCL1/5rrM5UoPSNBln2mwrfL33VmK', NULL, NULL, 263, NULL, NULL, 0, '2024-08-25 06:32:05', '2024-08-25 06:32:05'),
(280, 265, 'islam', '01928632227', 'mijanurislam@gmail.com', 'Chandura', '1', 'stockist-isp-00099.66cb24ee9fb78', 265, NULL, 'ITRHCL-000150', '$2y$12$dLXxdV0J5y.FH1gRb9EnpO7C6.r8rPqrGgrfjOOdR63hh9y4BpH0m', NULL, NULL, 265, 281, NULL, 0, '2024-08-25 06:34:54', '2024-08-25 06:37:50'),
(281, 280, 'Md Mamun Bhuya', '01956302675', 'mamunbhuya675@gmail.com', 'konabari', '1', 'stockist-isp-00064.66cb259db29c0', 280, 'A', 'ITRHCL-000151', '$2y$12$Y27TlfegIKpxATR8U4OXbemgMjZof13CZg.957dJ4fVMyoZeRfkrK', NULL, NULL, 280, 282, NULL, 0, '2024-08-25 06:37:50', '2024-08-25 06:39:45'),
(282, 281, 'Md Toffajjal Hossen', '01715912212', 'tofajjalhossen2212@gmail.com', 'konabari', '1', 'stockist-isp-00066.66cb2610de5c7', 281, 'A', 'ITRHCL-000152', '$2y$12$VMXcM85d4GTnptQKk4ea3.wJlDvAIXcD/cRrz76es1kUAlacsW/s2', NULL, NULL, 281, NULL, NULL, 0, '2024-08-25 06:39:45', '2024-08-25 06:39:45'),
(283, 266, 'Md Mizanur Rahman', '01643496603', 'mdwosama0@gmail.com', 'savar', '1', 'stockist-isp-0009.66cb2747ed90e', 266, 'B', 'ITRHCL-000153', '$2y$12$WqIfOGo/hbmXai8giSNzjunpG8QEHBicqTOc4Afw.gp7euU6wVzL.', NULL, NULL, 266, NULL, NULL, 0, '2024-08-25 06:44:56', '2024-08-25 06:44:56'),
(284, 239, 'md Shanto', '01615387343', 'shanto343@gmail.com', 'Ghasa', '1', 'stockist-isp-00075.66cc3cda7584f', 243, 'A', 'ITRHCL-000154', '$2y$12$oL0bA5jaIxD1iv/QLFrF5uxlzagX5640SA5Bck.bh1M2ss3pjDbwi', NULL, NULL, 243, 285, NULL, 0, '2024-08-26 02:29:14', '2024-08-26 02:31:27'),
(285, 239, 'Md Billal Hossen', '01639577456', 'billalhossen456@gmail.com', 'uttara', '1', 'stockist-isp-00053.66cc3d5f0a39f', 284, 'A', 'ITRHCL-000155', '$2y$12$QuQHoe0WgcRxC8wdO7epteqcOcr.TD7UipDfnvz1G9XpiRs6I7v32', NULL, NULL, 284, 286, 287, 0, '2024-08-26 02:31:27', '2024-08-26 02:37:34'),
(286, 239, 'Md Nahid Amin', '01817124094', 'nahidamin094@gmail.com', 'uttara', '1', 'stockist-isp-00081.66cc3df0e4292', 285, 'A', 'ITRHCL-000156', '$2y$12$C4TlwQncMs26sXuQexBq8e8A.YqImdFSRMFny81LzpPvlZ5fKMObK', NULL, NULL, 285, NULL, NULL, 0, '2024-08-26 02:33:53', '2024-08-26 02:33:53'),
(287, 239, 'Khaleda yasmin', '01846695464', 'khaledayasmin@gmail.com', 'uttara', '1', 'stockist-isp-00091.66cc3ece94e6e', 285, 'B', 'ITRHCL-000157', '$2y$12$6sIzI8fLwAw0fQjCMsNt2OvbnClN6ufGxc0Xy5hQd7jmhnGpHhEsm', NULL, NULL, 285, NULL, 290, 0, '2024-08-26 02:37:34', '2024-08-26 02:53:23'),
(288, 264, 'Md Idris Ali', '01301719442', 'mdidrisa57@gmail.com', 'Mymonsinga', '1', 'stockist-isp-00037.66cc3fc4a056c', 264, 'A', 'ITRHCL-000158', '$2y$12$S0yjAGyuYdUDpyXn9o2wiOGda9M04esMk2k5cdQlfaCbjTQ0dV7xO', NULL, NULL, 264, 297, 298, 0, '2024-08-26 02:41:40', '2024-08-27 00:20:41'),
(289, 183, 'Md Toffajal Sikder', '01937855017', 'toffajalsikder017@gmail.com', 'kaliganj', '1', 'stockist-isp-00043.66cc41ac139ce', 187, 'A', 'ITRHCL-000159', '$2y$12$7vfP3g/CpwCFDB0EjJTb5.oO6pcu2fJ8/9A5Dg4eQLIBc5Kr/22IS', NULL, NULL, 187, NULL, NULL, 0, '2024-08-26 02:49:48', '2024-08-26 02:49:48'),
(290, 285, 'Md Abdul Jalil', '01935072700', 'jalilabdul700@gmail.com', 'uttara', '1', 'stockist-isp-00077.66cc4283406a4', 287, 'B', 'ITRHCL-000160', '$2y$12$JVAuKt7uT.VU6PYml34nQuw6uCWR6BvSIJ8wHz7uYvWqJ1z4kgL3C', NULL, NULL, 287, NULL, NULL, 0, '2024-08-26 02:53:23', '2024-08-26 02:53:23'),
(291, 159, 'Md Mahfuzur Rahman', '01971624070', 'mahfuzurrahman070@gmail.com', 'Tongi', '1', 'stockist-isp-0007.66cd4ecadef00', 274, 'A', 'ITRHCL-000161', '$2y$12$2f3yWgqY6bnp.5Bm.sYOw.cI9Ic32aoDlcsZn/3RvPSnM77h5Pm3e', NULL, NULL, 274, NULL, NULL, 0, '2024-08-26 21:58:03', '2024-08-26 21:58:03'),
(292, 160, 'Kohenur Akter Mili', '01810499129', 'kohenuraktermili129@gmail.com', 'Tongi', '1', 'stockist-isp-00096.66cd4f1090c85', 275, 'B', 'ITRHCL-000162', '$2y$12$2uvEZGjWyK0oJTgO.F4syO.ETYk0moO1T0E2t8YRvYvYBZS6Q3AQ.', NULL, NULL, 275, NULL, NULL, 0, '2024-08-26 21:59:12', '2024-09-09 01:10:34'),
(293, 157, 'Mst Halima Akter', '01992345084', 'halimaakter084@gmail.com', 'Tongi', '1', 'stockist-isp-00010.66cd6c91d046e', 176, 'A', 'ITRHCL-000163', '$2y$12$dCseeYvexUwjQ9gx0/9NdO4UaIBexLbAmhokDmP93odnvbpHoU8Qa', NULL, NULL, 176, 294, NULL, 0, '2024-08-27 00:05:06', '2024-08-27 00:06:42'),
(294, 145, 'Mst Laiju Akter', '01333088415', 'laizuakter415@gmail.com', 'Tongi', '1', 'stockist-isp-00094.66cd6cf20a824', 293, 'A', 'ITRHCL-000164', '$2y$12$IjOC6Fb3kVGfm7ApYVy9duoblpN0MWHtFFp7ukZ9z7r5TeMwf2gxi', NULL, NULL, 293, NULL, NULL, 0, '2024-08-27 00:06:42', '2024-08-27 00:06:42'),
(295, 157, 'Biksh', '01925741231', 'bikash231@gmail.com', 'Tongi', '1', 'stockist-isp-00081.66cd6d462a54c', 180, 'B', 'ITRHCL-000165', '$2y$12$IkFwnwVmaU2AEv8bTmpkv.FtbfMS6vTa0gAgw8BDnfSVI3xhIkCi.', NULL, NULL, 180, NULL, 296, 0, '2024-08-27 00:08:06', '2024-09-09 01:10:11'),
(296, 157, 'Md Biplop', '01752675580', 'biplop5580@gmail.com', 'Tongi', '1', 'stockist-isp-00063.66cd6d9b9be18', 295, 'B', 'ITRHCL-000166', '$2y$12$6lW71SW5Q5530V8TXDgHOOtR/JGpjvQNVdvgsoPrCsAeLzKa/Zagm', NULL, NULL, 295, NULL, NULL, 0, '2024-08-27 00:09:31', '2024-08-27 00:09:31'),
(297, 288, 'Md Idris Ali', '01966781277', 'mdidrisa77@gmail.com', 'Tongi', '1', 'stockist-isp-00017.66cd6fe5a352b', 288, 'A', 'ITRHCL-000167', '$2y$12$qKSFA/PI4ztuQJ7/LcH7mO1bR0LgK1qvo3MwYqR86ra0RbkXrhmCe', NULL, NULL, 288, NULL, NULL, 0, '2024-08-27 00:19:17', '2024-08-27 00:19:17'),
(298, 288, 'Md Idris Ali', '01301875173', 'mdidrisa73@gmail.com', 'Tongi', '1', 'stockist-isp-00011.66cd7039576f5', 288, 'B', 'ITRHCL-000168', '$2y$12$t1vI70KzjzuE7Ep0BWm75uE2DrFaEFNotX..N5xSxMGr8x1/8r9g.', NULL, NULL, 288, NULL, NULL, 0, '2024-08-27 00:20:41', '2024-08-27 00:20:41'),
(299, 133, 'User 21', '014711523622', 'user21@gmail.com', 'Dhaka', '1', 'stockist-isp-000100.66de9cedcecf5', 135, 'A', 'ITRHCL-000169', '$2y$12$OLJvuvsQw73zKPnmRz7c8uyrvKc7pIp5fxen1b00S8GBmRaNk54eG', NULL, NULL, 135, NULL, NULL, 0, '2024-09-09 00:59:58', '2024-09-09 00:59:58'),
(300, 135, 'User 22', '01928523618', 'user22@gmail.com', 'Rangpur', '1', 'stockist-isp-00098.66de9da31d0ce', 135, 'B', 'ITRHCL-000170', '$2y$12$TKo1fr/10ErYcoHM54E2q.rRvm5LoPEUh5FytpFOMOx.7GzNq.G4i', NULL, NULL, 135, NULL, NULL, 0, '2024-09-09 01:02:59', '2024-09-09 01:02:59'),
(309, 134, 'Sonet', '01732379393', 'shawnshikdersonet@gmail.com', 'admin', '1', 'stockist-isp-00041.66ea7b1f05709', 134, 'B', 'ITRHCL-000171', '$2y$12$XyLo2S1XgTp4R3JSj4w6Ou7vScuLA58WVbAn3sfd8j1R9DxrMv4P.', NULL, NULL, 134, NULL, NULL, 1, '2024-09-18 01:02:55', '2024-09-25 11:42:59');

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_configurations`
--

CREATE TABLE `dashboard_configurations` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `color` varchar(191) NOT NULL,
  `configuration` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `depos`
--

CREATE TABLE `depos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `depo_name` varchar(255) NOT NULL,
  `contact_person_name` varchar(255) NOT NULL,
  `contact_number` varchar(255) NOT NULL,
  `depo_email_id` varchar(255) NOT NULL,
  `depo_address` varchar(255) NOT NULL,
  `depo_arya` varchar(255) NOT NULL,
  `depo_user_id` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `depos`
--

INSERT INTO `depos` (`id`, `depo_name`, `contact_person_name`, `contact_number`, `depo_email_id`, `depo_address`, `depo_arya`, `depo_user_id`, `password`, `photo`, `created_at`, `updated_at`) VALUES
(1, 'ITR HELTH CARE LTD', 'RAJU AHMED', '01976685506', 'mdraju2u@gmail.com', 'Life Care Hospital Vbon, House-13, 9 Floor-A, Sultana Rajiya Road, Auchpara, Kolleggate, Tongi, Gazipur\n', 'Tongi', 'depo-itrhcu-1001', '$2y$12$x5hD1Z/r2w9sOgZCCWEYBODcIFNyggYSK.BxMLWyTqjmBGA4AU3qm', NULL, NULL, NULL),
(2, 'Bernard Small', 'Morgan Nixon', '249', 'hijygyneje@mailinator.com', 'Porro repudiandae at', 'Quia omnis officia e', 'depo-itrhcu-1002', '$2y$12$t7207/gx1ESyxWfIW2iICOzSmCgocY/6AhHCeqK4rzKkI77o.tof2', NULL, NULL, NULL),
(4, 'Sheila Meadows', 'Amal Gillespie', '456', 'xevu@mailinator.com', 'Id aut minim est qu', 'Quasi ut tempora ali', 'depo-itrhcu-1003', '$2y$12$NeBzzdCFFON2JByKAegp6uqFCqT4eVuzksBs3PeAKgD6U9784hZjC', NULL, NULL, '2024-05-06 02:23:43'),
(7, 'Jeanette Branch', 'Jolene Merrill', '557', 'xakewy@mailinator.com', 'Similique asperiores', 'Suscipit consequatur', 'depo-itrhcu-1004', '$2y$12$TtWyEw1GCGUUg/PuXJjPYuwiHqr1kVFlTSgYhpUwIEgpCafFBN95W', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `discount_type` varchar(191) DEFAULT NULL,
  `discount_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `spg` varchar(100) DEFAULT NULL COMMENT 'Applicable in specified selling price group only. Use of applicable_in_spg column is discontinued',
  `applicable_in_cg` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_variations`
--

CREATE TABLE `discount_variations` (
  `discount_id` int(11) NOT NULL,
  `variation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_and_notes`
--

CREATE TABLE `document_and_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `notable_id` int(11) NOT NULL,
  `notable_type` varchar(191) NOT NULL,
  `heading` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equal_bonuses`
--

CREATE TABLE `equal_bonuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `bonus_amount` float(15,2) NOT NULL DEFAULT 0.00,
  `left_sum` float(15,2) DEFAULT 0.00,
  `right_sum` float(15,2) NOT NULL DEFAULT 0.00,
  `carry` float(15,2) NOT NULL DEFAULT 0.00,
  `carry_side` varchar(70) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `equal_bonuses`
--

INSERT INTO `equal_bonuses` (`id`, `user_id`, `bonus_amount`, `left_sum`, `right_sum`, `carry`, `carry_side`, `date`, `created_at`, `updated_at`) VALUES
(57, 121, 23.75, 950.00, 475.00, 475.00, 'left', '2024-10-01', '2024-10-01 00:28:24', '2024-10-01 00:28:24'),
(58, 133, 11.25, 250.00, 225.00, 25.00, 'left', '2024-10-01', '2024-10-01 00:28:24', '2024-10-01 00:28:24');

-- --------------------------------------------------------

--
-- Table structure for table `equel_bonus_user_to_places`
--

CREATE TABLE `equel_bonus_user_to_places` (
  `id` int(10) UNSIGNED NOT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `place_side` varchar(5) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `logged_user_id` bigint(20) DEFAULT NULL,
  `layer` tinyint(4) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `carry_forward_amount` decimal(12,2) DEFAULT NULL,
  `assign_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `name`, `business_id`, `code`, `parent_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Lunch Bill', 1, 'Lunch Bill', NULL, '2023-12-13 15:23:32', '2023-09-01 11:46:54', '2023-12-13 15:23:32'),
(2, 'Tea Biskut Cost', 1, 'Tea Biskut Cost', NULL, '2023-12-13 15:23:50', '2023-09-01 11:47:35', '2023-12-13 15:23:50'),
(3, 'office cost', 1, 'office cost', NULL, NULL, '2023-09-01 11:47:59', '2023-09-01 11:47:59'),
(4, 'Office rent', 1, 'Office rent', NULL, '2023-12-13 15:23:47', '2023-09-01 11:48:25', '2023-12-13 15:23:47'),
(5, 'Parsonal Loan', 1, 'Parsonal Loan', NULL, '2023-12-13 15:23:41', '2023-09-01 11:48:53', '2023-12-13 15:23:41'),
(6, 'Malamal bill', 1, 'Malamal bill', NULL, '2023-12-13 15:23:35', '2023-09-01 16:28:01', '2023-12-13 15:23:35'),
(7, 'kobutor & fish  cost', 1, 'kobutor & fish  cost', NULL, '2023-12-13 15:23:29', '2023-09-03 16:26:01', '2023-12-13 15:23:29');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gardianship_bonuses`
--

CREATE TABLE `gardianship_bonuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `c_user_id` bigint(20) UNSIGNED NOT NULL,
  `month` varchar(255) NOT NULL,
  `purchaseBonus` decimal(8,0) NOT NULL DEFAULT 0,
  `creatingBonus` decimal(8,0) NOT NULL DEFAULT 0,
  `reCreatingBonus` decimal(8,0) NOT NULL DEFAULT 0,
  `equalBonus` decimal(8,0) NOT NULL DEFAULT 0,
  `stockiestReferBonus` decimal(8,0) NOT NULL DEFAULT 0,
  `total` decimal(8,0) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_sub_taxes`
--

CREATE TABLE `group_sub_taxes` (
  `group_tax_id` int(10) UNSIGNED NOT NULL,
  `tax_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gs_distribute_lists`
--

CREATE TABLE `gs_distribute_lists` (
  `id` int(12) NOT NULL,
  `month` varchar(191) DEFAULT NULL,
  `year` varchar(191) DEFAULT NULL,
  `date` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gs_distribute_lists`
--

INSERT INTO `gs_distribute_lists` (`id`, `month`, `year`, `date`, `created_at`, `updated_at`) VALUES
(2, '8', '2024', '8-2024', '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(3, '7', '2024', '7-2024', '2024-09-10 01:58:49', '2024-09-10 01:58:49');

-- --------------------------------------------------------

--
-- Table structure for table `guardianship_bonuses`
--

CREATE TABLE `guardianship_bonuses` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `month` varchar(255) NOT NULL,
  `total` float(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guardianship_bonuses`
--

INSERT INTO `guardianship_bonuses` (`id`, `user_id`, `month`, `total`, `created_at`, `updated_at`) VALUES
(1, 121, '8-2024', 9.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(2, 121, '8-2024', 9.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(3, 132, '8-2024', 4.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(4, 132, '8-2024', 4.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(5, 133, '8-2024', 6.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(6, 133, '8-2024', 6.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(7, 136, '8-2024', 4.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(8, 138, '8-2024', 0.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(9, 139, '8-2024', 0.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(10, 139, '8-2024', 0.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(11, 140, '8-2024', 0.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(12, 142, '8-2024', 0.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(13, 137, '8-2024', 0.00, '2024-09-10 01:43:59', '2024-09-10 01:43:59'),
(14, 144, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(15, 145, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(16, 141, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(17, 141, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(18, 147, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(19, 147, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(20, 148, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(21, 148, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(22, 149, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(23, 150, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(24, 152, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(25, 145, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(26, 145, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(27, 143, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(28, 158, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(29, 143, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(30, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(31, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(32, 162, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(33, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(34, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(35, 165, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(36, 166, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(37, 167, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(38, 168, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(39, 169, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(40, 170, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(41, 157, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(42, 157, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(43, 153, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(44, 153, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(45, 157, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(46, 145, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(47, 145, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(48, 157, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(49, 157, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(50, 155, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(51, 155, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(52, 181, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(53, 183, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(54, 183, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(55, 185, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(56, 186, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(57, 183, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(58, 183, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(59, 185, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(60, 162, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(61, 162, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(62, 192, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(63, 162, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(64, 162, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(65, 162, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(66, 163, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(67, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(68, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(69, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(70, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(71, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(72, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(73, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(74, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(75, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(76, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(77, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(78, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(79, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(80, 207, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(81, 205, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(82, 212, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(83, 161, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(84, 161, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(85, 161, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(86, 161, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(87, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(88, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(89, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(90, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(91, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(92, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(93, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(94, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(95, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(96, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(97, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(98, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(99, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(100, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(101, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(102, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(103, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(104, 174, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(105, 235, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(106, 235, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(107, 146, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(108, 236, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(109, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(110, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(111, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(112, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(113, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(114, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(115, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(116, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(117, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(118, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(119, 146, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(120, 175, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(121, 251, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(122, 251, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(123, 251, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(124, 254, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(125, 254, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(126, 251, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(127, 257, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(128, 257, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(129, 254, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(130, 154, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(131, 154, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(132, 154, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(133, 154, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(134, 154, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(135, 154, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(136, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(137, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(138, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(139, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(140, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(141, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(142, 121, '8-2024', 9.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(143, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(144, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(145, 142, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(146, 276, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(147, 276, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(148, 263, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(149, 265, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(150, 280, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(151, 281, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(152, 266, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(153, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(154, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(155, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(156, 239, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(157, 264, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(158, 183, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(159, 285, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(160, 159, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(161, 160, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(162, 157, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(163, 145, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(164, 157, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(165, 157, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(166, 288, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(167, 288, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(168, 133, '8-2024', 6.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(169, 135, '8-2024', 0.00, '2024-09-10 01:44:00', '2024-09-10 01:44:00'),
(170, 121, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(171, 121, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(172, 132, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(173, 132, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(174, 133, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(175, 133, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(176, 136, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(177, 138, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(178, 139, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(179, 139, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(180, 140, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(181, 142, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(182, 137, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(183, 144, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(184, 145, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(185, 141, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(186, 141, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(187, 147, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(188, 147, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(189, 148, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(190, 148, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(191, 149, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(192, 150, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(193, 152, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(194, 145, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(195, 145, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(196, 143, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(197, 158, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(198, 143, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(199, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(200, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(201, 162, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(202, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(203, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(204, 165, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(205, 166, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(206, 167, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(207, 168, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(208, 169, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(209, 170, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(210, 157, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(211, 157, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(212, 153, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(213, 153, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(214, 157, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(215, 145, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(216, 145, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(217, 157, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(218, 157, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(219, 155, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(220, 155, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(221, 181, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(222, 183, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(223, 183, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(224, 185, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(225, 186, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(226, 183, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(227, 183, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(228, 185, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(229, 162, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(230, 162, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(231, 192, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(232, 162, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(233, 162, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(234, 162, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(235, 163, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(236, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(237, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(238, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(239, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(240, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(241, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(242, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(243, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(244, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(245, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(246, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(247, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(248, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(249, 207, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(250, 205, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(251, 212, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(252, 161, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(253, 161, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(254, 161, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(255, 161, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(256, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(257, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(258, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(259, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(260, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(261, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(262, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(263, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(264, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(265, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(266, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(267, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(268, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(269, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(270, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(271, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(272, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(273, 174, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(274, 235, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(275, 235, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(276, 146, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(277, 236, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(278, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(279, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(280, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(281, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(282, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(283, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(284, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(285, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(286, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(287, 239, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(288, 146, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(289, 175, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(290, 251, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(291, 251, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(292, 251, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(293, 254, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(294, 254, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(295, 251, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(296, 257, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(297, 257, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(298, 254, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(299, 154, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(300, 154, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(301, 154, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(302, 154, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(303, 154, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(304, 154, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(305, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(306, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(307, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(308, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(309, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(310, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(311, 121, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(312, 159, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(313, 160, '7-2024', 0.00, '2024-09-10 01:58:48', '2024-09-10 01:58:48'),
(314, 142, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(315, 276, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(316, 276, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(317, 263, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(318, 265, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(319, 280, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(320, 281, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(321, 266, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(322, 239, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(323, 239, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(324, 239, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(325, 239, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(326, 264, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(327, 183, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(328, 285, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(329, 159, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(330, 160, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(331, 157, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(332, 145, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(333, 157, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(334, 157, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(335, 288, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(336, 288, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(337, 133, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49'),
(338, 135, '7-2024', 0.00, '2024-09-10 01:58:49', '2024-09-10 01:58:49');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_layouts`
--

CREATE TABLE `invoice_layouts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `header_text` text DEFAULT NULL,
  `invoice_no_prefix` varchar(191) DEFAULT NULL,
  `quotation_no_prefix` varchar(191) DEFAULT NULL,
  `invoice_heading` varchar(191) DEFAULT NULL,
  `sub_heading_line1` varchar(191) DEFAULT NULL,
  `sub_heading_line2` varchar(191) DEFAULT NULL,
  `sub_heading_line3` varchar(191) DEFAULT NULL,
  `sub_heading_line4` varchar(191) DEFAULT NULL,
  `sub_heading_line5` varchar(191) DEFAULT NULL,
  `invoice_heading_not_paid` varchar(191) DEFAULT NULL,
  `invoice_heading_paid` varchar(191) DEFAULT NULL,
  `quotation_heading` varchar(191) DEFAULT NULL,
  `sub_total_label` varchar(191) DEFAULT NULL,
  `discount_label` varchar(191) DEFAULT NULL,
  `tax_label` varchar(191) DEFAULT NULL,
  `total_label` varchar(191) DEFAULT NULL,
  `round_off_label` varchar(191) DEFAULT NULL,
  `total_due_label` varchar(191) DEFAULT NULL,
  `paid_label` varchar(191) DEFAULT NULL,
  `show_client_id` tinyint(1) NOT NULL DEFAULT 0,
  `client_id_label` varchar(191) DEFAULT NULL,
  `client_tax_label` varchar(191) DEFAULT NULL,
  `date_label` varchar(191) DEFAULT NULL,
  `date_time_format` varchar(191) DEFAULT NULL,
  `show_time` tinyint(1) NOT NULL DEFAULT 1,
  `show_brand` tinyint(1) NOT NULL DEFAULT 0,
  `show_sku` tinyint(1) NOT NULL DEFAULT 1,
  `show_cat_code` tinyint(1) NOT NULL DEFAULT 1,
  `show_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `show_lot` tinyint(1) NOT NULL DEFAULT 0,
  `show_image` tinyint(1) NOT NULL DEFAULT 0,
  `show_sale_description` tinyint(1) NOT NULL DEFAULT 0,
  `sales_person_label` varchar(191) DEFAULT NULL,
  `show_sales_person` tinyint(1) NOT NULL DEFAULT 0,
  `table_product_label` varchar(191) DEFAULT NULL,
  `table_qty_label` varchar(191) DEFAULT NULL,
  `table_unit_price_label` varchar(191) DEFAULT NULL,
  `table_subtotal_label` varchar(191) DEFAULT NULL,
  `cat_code_label` varchar(191) DEFAULT NULL,
  `logo` varchar(191) DEFAULT NULL,
  `show_logo` tinyint(1) NOT NULL DEFAULT 0,
  `show_business_name` tinyint(1) NOT NULL DEFAULT 0,
  `show_location_name` tinyint(1) NOT NULL DEFAULT 1,
  `show_landmark` tinyint(1) NOT NULL DEFAULT 1,
  `show_city` tinyint(1) NOT NULL DEFAULT 1,
  `show_state` tinyint(1) NOT NULL DEFAULT 1,
  `show_zip_code` tinyint(1) NOT NULL DEFAULT 1,
  `show_country` tinyint(1) NOT NULL DEFAULT 1,
  `show_mobile_number` tinyint(1) NOT NULL DEFAULT 1,
  `show_alternate_number` tinyint(1) NOT NULL DEFAULT 0,
  `show_email` tinyint(1) NOT NULL DEFAULT 0,
  `show_tax_1` tinyint(1) NOT NULL DEFAULT 1,
  `show_tax_2` tinyint(1) NOT NULL DEFAULT 0,
  `show_barcode` tinyint(1) NOT NULL DEFAULT 0,
  `show_payments` tinyint(1) NOT NULL DEFAULT 0,
  `show_customer` tinyint(1) NOT NULL DEFAULT 0,
  `customer_label` varchar(191) DEFAULT NULL,
  `commission_agent_label` varchar(191) DEFAULT NULL,
  `show_commission_agent` tinyint(1) NOT NULL DEFAULT 0,
  `show_reward_point` tinyint(1) NOT NULL DEFAULT 0,
  `highlight_color` varchar(10) DEFAULT NULL,
  `footer_text` text DEFAULT NULL,
  `module_info` text DEFAULT NULL,
  `common_settings` text DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `business_id` int(10) UNSIGNED NOT NULL,
  `show_qr_code` tinyint(1) NOT NULL DEFAULT 0,
  `qr_code_fields` text DEFAULT NULL,
  `design` varchar(190) DEFAULT 'classic',
  `cn_heading` varchar(191) DEFAULT NULL COMMENT 'cn = credit note',
  `cn_no_label` varchar(191) DEFAULT NULL,
  `cn_amount_label` varchar(191) DEFAULT NULL,
  `table_tax_headings` text DEFAULT NULL,
  `show_previous_bal` tinyint(1) NOT NULL DEFAULT 0,
  `prev_bal_label` varchar(191) DEFAULT NULL,
  `change_return_label` varchar(191) DEFAULT NULL,
  `product_custom_fields` text DEFAULT NULL,
  `contact_custom_fields` text DEFAULT NULL,
  `location_custom_fields` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_layouts`
--

INSERT INTO `invoice_layouts` (`id`, `name`, `header_text`, `invoice_no_prefix`, `quotation_no_prefix`, `invoice_heading`, `sub_heading_line1`, `sub_heading_line2`, `sub_heading_line3`, `sub_heading_line4`, `sub_heading_line5`, `invoice_heading_not_paid`, `invoice_heading_paid`, `quotation_heading`, `sub_total_label`, `discount_label`, `tax_label`, `total_label`, `round_off_label`, `total_due_label`, `paid_label`, `show_client_id`, `client_id_label`, `client_tax_label`, `date_label`, `date_time_format`, `show_time`, `show_brand`, `show_sku`, `show_cat_code`, `show_expiry`, `show_lot`, `show_image`, `show_sale_description`, `sales_person_label`, `show_sales_person`, `table_product_label`, `table_qty_label`, `table_unit_price_label`, `table_subtotal_label`, `cat_code_label`, `logo`, `show_logo`, `show_business_name`, `show_location_name`, `show_landmark`, `show_city`, `show_state`, `show_zip_code`, `show_country`, `show_mobile_number`, `show_alternate_number`, `show_email`, `show_tax_1`, `show_tax_2`, `show_barcode`, `show_payments`, `show_customer`, `customer_label`, `commission_agent_label`, `show_commission_agent`, `show_reward_point`, `highlight_color`, `footer_text`, `module_info`, `common_settings`, `is_default`, `business_id`, `show_qr_code`, `qr_code_fields`, `design`, `cn_heading`, `cn_no_label`, `cn_amount_label`, `table_tax_headings`, `show_previous_bal`, `prev_bal_label`, `change_return_label`, `product_custom_fields`, `contact_custom_fields`, `location_custom_fields`, `created_at`, `updated_at`) VALUES
(1, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', NULL, 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 1, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', NULL, 0, 0, '#000000', '', NULL, NULL, 1, 1, 0, NULL, 'classic', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-02-23 22:00:02', '2023-02-23 22:00:02');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_schemes`
--

CREATE TABLE `invoice_schemes` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `scheme_type` enum('blank','year') NOT NULL,
  `prefix` varchar(191) DEFAULT NULL,
  `start_number` int(11) DEFAULT NULL,
  `invoice_count` int(11) NOT NULL DEFAULT 0,
  `total_digits` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_schemes`
--

INSERT INTO `invoice_schemes` (`id`, `business_id`, `name`, `scheme_type`, `prefix`, `start_number`, `invoice_count`, `total_digits`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 1, 'Default', 'blank', '', 1, 285, 4, 1, '2023-02-23 22:00:02', '2024-08-01 16:40:46');

-- --------------------------------------------------------

--
-- Table structure for table `ip_active`
--

CREATE TABLE `ip_active` (
  `id` int(11) NOT NULL,
  `purchase_bonus` varchar(25) NOT NULL,
  `creating_bonus` varchar(25) NOT NULL,
  `re_creating_bonus` varchar(25) NOT NULL,
  `equal_bonus` varchar(25) NOT NULL,
  `rank_reward_bonus` varchar(25) NOT NULL,
  `championship_bonus` varchar(25) NOT NULL,
  `guardianship_bonus` varchar(25) NOT NULL,
  `after_death_allowance` varchar(25) NOT NULL,
  `company_profit_share` varchar(25) NOT NULL,
  `stokist_bonus` varchar(25) NOT NULL,
  `stokist_refer_bonus` varchar(25) NOT NULL,
  `depo_bonus` varchar(25) NOT NULL,
  `company_fund` varchar(25) NOT NULL,
  `_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ip_active`
--

INSERT INTO `ip_active` (`id`, `purchase_bonus`, `creating_bonus`, `re_creating_bonus`, `equal_bonus`, `rank_reward_bonus`, `championship_bonus`, `guardianship_bonus`, `after_death_allowance`, `company_profit_share`, `stokist_bonus`, `stokist_refer_bonus`, `depo_bonus`, `company_fund`, `_token`) VALUES
(1, '10%', '10%', '10%', '5%', '10%', '5%', '3%', '2%', '5%', '7%', '2%', '4%', '7%', 'KR3Rh86E6nZozn6XxhfkoZkovbrlHuYT0ceMStMZ');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `file_name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_media_type` varchar(191) DEFAULT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`id`, `business_id`, `file_name`, `description`, `uploaded_by`, `model_type`, `model_media_type`, `model_id`, `created_at`, `updated_at`) VALUES
(2, 1, '1720856636_296792867_itr logo.jpeg', NULL, 1, 'App\\User', NULL, 1, '2024-07-13 13:43:56', '2024-07-13 13:43:56');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2017_07_05_071953_create_currencies_table', 1),
(9, '2017_07_05_073658_create_business_table', 1),
(10, '2017_07_22_075923_add_business_id_users_table', 1),
(11, '2017_07_23_113209_create_brands_table', 1),
(12, '2017_07_26_083429_create_permission_tables', 1),
(13, '2017_07_26_110000_create_tax_rates_table', 1),
(14, '2017_07_26_122313_create_units_table', 1),
(15, '2017_07_27_075706_create_contacts_table', 1),
(16, '2017_08_04_071038_create_categories_table', 1),
(17, '2017_08_08_115903_create_products_table', 1),
(18, '2017_08_09_061616_create_variation_templates_table', 1),
(19, '2017_08_09_061638_create_variation_value_templates_table', 1),
(20, '2017_08_10_061146_create_product_variations_table', 1),
(21, '2017_08_10_061216_create_variations_table', 1),
(22, '2017_08_19_054827_create_transactions_table', 1),
(23, '2017_08_31_073533_create_purchase_lines_table', 1),
(24, '2017_10_15_064638_create_transaction_payments_table', 1),
(25, '2017_10_31_065621_add_default_sales_tax_to_business_table', 1),
(26, '2017_11_20_051930_create_table_group_sub_taxes', 1),
(27, '2017_11_20_063603_create_transaction_sell_lines', 1),
(28, '2017_11_21_064540_create_barcodes_table', 1),
(29, '2017_11_23_181237_create_invoice_schemes_table', 1),
(30, '2017_12_25_122822_create_business_locations_table', 1),
(31, '2017_12_25_160253_add_location_id_to_transactions_table', 1),
(32, '2017_12_25_163227_create_variation_location_details_table', 1),
(33, '2018_01_04_115627_create_sessions_table', 1),
(34, '2018_01_05_112817_create_invoice_layouts_table', 1),
(35, '2018_01_06_112303_add_invoice_scheme_id_and_invoice_layout_id_to_business_locations', 1),
(36, '2018_01_08_104124_create_expense_categories_table', 1),
(37, '2018_01_08_123327_modify_transactions_table_for_expenses', 1),
(38, '2018_01_09_111005_modify_payment_status_in_transactions_table', 1),
(39, '2018_01_09_111109_add_paid_on_column_to_transaction_payments_table', 1),
(40, '2018_01_25_172439_add_printer_related_fields_to_business_locations_table', 1),
(41, '2018_01_27_184322_create_printers_table', 1),
(42, '2018_01_30_181442_create_cash_registers_table', 1),
(43, '2018_01_31_125836_create_cash_register_transactions_table', 1),
(44, '2018_02_07_173326_modify_business_table', 1),
(45, '2018_02_08_105425_add_enable_product_expiry_column_to_business_table', 1),
(46, '2018_02_08_111027_add_expiry_period_and_expiry_period_type_columns_to_products_table', 1),
(47, '2018_02_08_131118_add_mfg_date_and_exp_date_purchase_lines_table', 1),
(48, '2018_02_08_155348_add_exchange_rate_to_transactions_table', 1),
(49, '2018_02_09_124945_modify_transaction_payments_table_for_contact_payments', 1),
(50, '2018_02_12_113640_create_transaction_sell_lines_purchase_lines_table', 1),
(51, '2018_02_12_114605_add_quantity_sold_in_purchase_lines_table', 1),
(52, '2018_02_13_183323_alter_decimal_fields_size', 1),
(53, '2018_02_14_161928_add_transaction_edit_days_to_business_table', 1),
(54, '2018_02_15_161032_add_document_column_to_transactions_table', 1),
(55, '2018_02_17_124709_add_more_options_to_invoice_layouts', 1),
(56, '2018_02_19_111517_add_keyboard_shortcut_column_to_business_table', 1),
(57, '2018_02_19_121537_stock_adjustment_move_to_transaction_table', 1),
(58, '2018_02_20_165505_add_is_direct_sale_column_to_transactions_table', 1),
(59, '2018_02_21_105329_create_system_table', 1),
(60, '2018_02_23_100549_version_1_2', 1),
(61, '2018_02_23_125648_add_enable_editing_sp_from_purchase_column_to_business_table', 1),
(62, '2018_02_26_103612_add_sales_commission_agent_column_to_business_table', 1),
(63, '2018_02_26_130519_modify_users_table_for_sales_cmmsn_agnt', 1),
(64, '2018_02_26_134500_add_commission_agent_to_transactions_table', 1),
(65, '2018_02_27_121422_add_item_addition_method_to_business_table', 1),
(66, '2018_02_27_170232_modify_transactions_table_for_stock_transfer', 1),
(67, '2018_03_05_153510_add_enable_inline_tax_column_to_business_table', 1),
(68, '2018_03_06_210206_modify_product_barcode_types', 1),
(69, '2018_03_13_181541_add_expiry_type_to_business_table', 1),
(70, '2018_03_16_113446_product_expiry_setting_for_business', 1),
(71, '2018_03_19_113601_add_business_settings_options', 1),
(72, '2018_03_26_125334_add_pos_settings_to_business_table', 1),
(73, '2018_03_26_165350_create_customer_groups_table', 1),
(74, '2018_03_27_122720_customer_group_related_changes_in_tables', 1),
(75, '2018_03_29_110138_change_tax_field_to_nullable_in_business_table', 1),
(76, '2018_03_29_115502_add_changes_for_sr_number_in_products_and_sale_lines_table', 1),
(77, '2018_03_29_134340_add_inline_discount_fields_in_purchase_lines', 1),
(78, '2018_03_31_140921_update_transactions_table_exchange_rate', 1),
(79, '2018_04_03_103037_add_contact_id_to_contacts_table', 1),
(80, '2018_04_03_122709_add_changes_to_invoice_layouts_table', 1),
(81, '2018_04_09_135320_change_exchage_rate_size_in_business_table', 1),
(82, '2018_04_17_123122_add_lot_number_to_business', 1),
(83, '2018_04_17_160845_add_product_racks_table', 1),
(84, '2018_04_20_182015_create_res_tables_table', 1),
(85, '2018_04_24_105246_restaurant_fields_in_transaction_table', 1),
(86, '2018_04_24_114149_add_enabled_modules_business_table', 1),
(87, '2018_04_24_133704_add_modules_fields_in_invoice_layout_table', 1),
(88, '2018_04_27_132653_quotation_related_change', 1),
(89, '2018_05_02_104439_add_date_format_and_time_format_to_business', 1),
(90, '2018_05_02_111939_add_sell_return_to_transaction_payments', 1),
(91, '2018_05_14_114027_add_rows_positions_for_products', 1),
(92, '2018_05_14_125223_add_weight_to_products_table', 1),
(93, '2018_05_14_164754_add_opening_stock_permission', 1),
(94, '2018_05_15_134729_add_design_to_invoice_layouts', 1),
(95, '2018_05_16_183307_add_tax_fields_invoice_layout', 1),
(96, '2018_05_18_191956_add_sell_return_to_transaction_table', 1),
(97, '2018_05_21_131349_add_custom_fileds_to_contacts_table', 1),
(98, '2018_05_21_131607_invoice_layout_fields_for_sell_return', 1),
(99, '2018_05_21_131949_add_custom_fileds_and_website_to_business_locations_table', 1),
(100, '2018_05_22_123527_create_reference_counts_table', 1),
(101, '2018_05_22_154540_add_ref_no_prefixes_column_to_business_table', 1),
(102, '2018_05_24_132620_add_ref_no_column_to_transaction_payments_table', 1),
(103, '2018_05_24_161026_add_location_id_column_to_business_location_table', 1),
(104, '2018_05_25_180603_create_modifiers_related_table', 1),
(105, '2018_05_29_121714_add_purchase_line_id_to_stock_adjustment_line_table', 1),
(106, '2018_05_31_114645_add_res_order_status_column_to_transactions_table', 1),
(107, '2018_06_05_103530_rename_purchase_line_id_in_stock_adjustment_lines_table', 1),
(108, '2018_06_05_111905_modify_products_table_for_modifiers', 1),
(109, '2018_06_06_110524_add_parent_sell_line_id_column_to_transaction_sell_lines_table', 1),
(110, '2018_06_07_152443_add_is_service_staff_to_roles_table', 1),
(111, '2018_06_07_182258_add_image_field_to_products_table', 1),
(112, '2018_06_13_133705_create_bookings_table', 1),
(113, '2018_06_15_173636_add_email_column_to_contacts_table', 1),
(114, '2018_06_27_182835_add_superadmin_related_fields_business', 1),
(115, '2018_07_10_101913_add_custom_fields_to_products_table', 1),
(116, '2018_07_17_103434_add_sales_person_name_label_to_invoice_layouts_table', 1),
(117, '2018_07_17_163920_add_theme_skin_color_column_to_business_table', 1),
(118, '2018_07_24_160319_add_lot_no_line_id_to_transaction_sell_lines_table', 1),
(119, '2018_07_25_110004_add_show_expiry_and_show_lot_colums_to_invoice_layouts_table', 1),
(120, '2018_07_25_172004_add_discount_columns_to_transaction_sell_lines_table', 1),
(121, '2018_07_26_124720_change_design_column_type_in_invoice_layouts_table', 1),
(122, '2018_07_26_170424_add_unit_price_before_discount_column_to_transaction_sell_line_table', 1),
(123, '2018_07_28_103614_add_credit_limit_column_to_contacts_table', 1),
(124, '2018_08_08_110755_add_new_payment_methods_to_transaction_payments_table', 1),
(125, '2018_08_08_122225_modify_cash_register_transactions_table_for_new_payment_methods', 1),
(126, '2018_08_14_104036_add_opening_balance_type_to_transactions_table', 1),
(127, '2018_09_04_155900_create_accounts_table', 1),
(128, '2018_09_06_114438_create_selling_price_groups_table', 1),
(129, '2018_09_06_154057_create_variation_group_prices_table', 1),
(130, '2018_09_07_102413_add_permission_to_access_default_selling_price', 1),
(131, '2018_09_07_134858_add_selling_price_group_id_to_transactions_table', 1),
(132, '2018_09_10_112448_update_product_type_to_single_if_null_in_products_table', 1),
(133, '2018_09_10_152703_create_account_transactions_table', 1),
(134, '2018_09_10_173656_add_account_id_column_to_transaction_payments_table', 1),
(135, '2018_09_19_123914_create_notification_templates_table', 1),
(136, '2018_09_22_110504_add_sms_and_email_settings_columns_to_business_table', 1),
(137, '2018_09_24_134942_add_lot_no_line_id_to_stock_adjustment_lines_table', 1),
(138, '2018_09_26_105557_add_transaction_payments_for_existing_expenses', 1),
(139, '2018_09_27_111609_modify_transactions_table_for_purchase_return', 1),
(140, '2018_09_27_131154_add_quantity_returned_column_to_purchase_lines_table', 1),
(141, '2018_10_02_131401_add_return_quantity_column_to_transaction_sell_lines_table', 1),
(142, '2018_10_03_104918_add_qty_returned_column_to_transaction_sell_lines_purchase_lines_table', 1),
(143, '2018_10_03_185947_add_default_notification_templates_to_database', 1),
(144, '2018_10_09_153105_add_business_id_to_transaction_payments_table', 1),
(145, '2018_10_16_135229_create_permission_for_sells_and_purchase', 1),
(146, '2018_10_22_114441_add_columns_for_variable_product_modifications', 1),
(147, '2018_10_22_134428_modify_variable_product_data', 1),
(148, '2018_10_30_181558_add_table_tax_headings_to_invoice_layout', 1),
(149, '2018_10_31_122619_add_pay_terms_field_transactions_table', 1),
(150, '2018_10_31_161328_add_new_permissions_for_pos_screen', 1),
(151, '2018_10_31_174752_add_access_selected_contacts_only_to_users_table', 1),
(152, '2018_10_31_175627_add_user_contact_access', 1),
(153, '2018_10_31_180559_add_auto_send_sms_column_to_notification_templates_table', 1),
(154, '2018_11_02_171949_change_card_type_column_to_varchar_in_transaction_payments_table', 1),
(155, '2018_11_08_105621_add_role_permissions', 1),
(156, '2018_11_26_114135_add_is_suspend_column_to_transactions_table', 1),
(157, '2018_11_28_104410_modify_units_table_for_multi_unit', 1),
(158, '2018_11_28_170952_add_sub_unit_id_to_purchase_lines_and_sell_lines', 1),
(159, '2018_11_29_115918_add_primary_key_in_system_table', 1),
(160, '2018_12_03_185546_add_product_description_column_to_products_table', 1),
(161, '2018_12_06_114937_modify_system_table_and_users_table', 1),
(162, '2018_12_13_160007_add_custom_fields_display_options_to_invoice_layouts_table', 1),
(163, '2018_12_14_103307_modify_system_table', 1),
(164, '2018_12_18_133837_add_prev_balance_due_columns_to_invoice_layouts_table', 1),
(165, '2018_12_18_170656_add_invoice_token_column_to_transaction_table', 1),
(166, '2018_12_20_133639_add_date_time_format_column_to_invoice_layouts_table', 1),
(167, '2018_12_21_120659_add_recurring_invoice_fields_to_transactions_table', 1),
(168, '2018_12_24_154933_create_notifications_table', 1),
(169, '2019_01_08_112015_add_document_column_to_transaction_payments_table', 1),
(170, '2019_01_10_124645_add_account_permission', 1),
(171, '2019_01_16_125825_add_subscription_no_column_to_transactions_table', 1),
(172, '2019_01_28_111647_add_order_addresses_column_to_transactions_table', 1),
(173, '2019_02_13_173821_add_is_inactive_column_to_products_table', 1),
(174, '2019_02_19_103118_create_discounts_table', 1),
(175, '2019_02_21_120324_add_discount_id_column_to_transaction_sell_lines_table', 1),
(176, '2019_02_21_134324_add_permission_for_discount', 1),
(177, '2019_03_04_170832_add_service_staff_columns_to_transaction_sell_lines_table', 1),
(178, '2019_03_09_102425_add_sub_type_column_to_transactions_table', 1),
(179, '2019_03_09_124457_add_indexing_transaction_sell_lines_purchase_lines_table', 1),
(180, '2019_03_12_120336_create_activity_log_table', 1),
(181, '2019_03_15_132925_create_media_table', 1),
(182, '2019_05_08_130339_add_indexing_to_parent_id_in_transaction_payments_table', 1),
(183, '2019_05_10_132311_add_missing_column_indexing', 1),
(184, '2019_05_14_091812_add_show_image_column_to_invoice_layouts_table', 1),
(185, '2019_05_25_104922_add_view_purchase_price_permission', 1),
(186, '2019_06_17_103515_add_profile_informations_columns_to_users_table', 1),
(187, '2019_06_18_135524_add_permission_to_view_own_sales_only', 1),
(188, '2019_06_19_112058_add_database_changes_for_reward_points', 1),
(189, '2019_06_28_133732_change_type_column_to_string_in_transactions_table', 1),
(190, '2019_07_13_111420_add_is_created_from_api_column_to_transactions_table', 1),
(191, '2019_07_15_165136_add_fields_for_combo_product', 1),
(192, '2019_07_19_103446_add_mfg_quantity_used_column_to_purchase_lines_table', 1),
(193, '2019_07_22_152649_add_not_for_selling_in_product_table', 1),
(194, '2019_07_29_185351_add_show_reward_point_column_to_invoice_layouts_table', 1),
(195, '2019_08_08_162302_add_sub_units_related_fields', 1),
(196, '2019_08_26_133419_update_price_fields_decimal_point', 1),
(197, '2019_09_02_160054_remove_location_permissions_from_roles', 1),
(198, '2019_09_03_185259_add_permission_for_pos_screen', 1),
(199, '2019_09_04_163141_add_location_id_to_cash_registers_table', 1),
(200, '2019_09_04_184008_create_types_of_services_table', 1),
(201, '2019_09_06_131445_add_types_of_service_fields_to_transactions_table', 1),
(202, '2019_09_09_134810_add_default_selling_price_group_id_column_to_business_locations_table', 1),
(203, '2019_09_12_105616_create_product_locations_table', 1),
(204, '2019_09_17_122522_add_custom_labels_column_to_business_table', 1),
(205, '2019_09_18_164319_add_shipping_fields_to_transactions_table', 1),
(206, '2019_09_19_170927_close_all_active_registers', 1),
(207, '2019_09_23_161906_add_media_description_cloumn_to_media_table', 1),
(208, '2019_10_18_155633_create_account_types_table', 1),
(209, '2019_10_22_163335_add_common_settings_column_to_business_table', 1),
(210, '2019_10_29_132521_add_update_purchase_status_permission', 1),
(211, '2019_11_09_110522_add_indexing_to_lot_number', 1),
(212, '2019_11_19_170824_add_is_active_column_to_business_locations_table', 1),
(213, '2019_11_21_162913_change_quantity_field_types_to_decimal', 1),
(214, '2019_11_25_160340_modify_categories_table_for_polymerphic_relationship', 1),
(215, '2019_12_02_105025_create_warranties_table', 1),
(216, '2019_12_03_180342_add_common_settings_field_to_invoice_layouts_table', 1),
(217, '2019_12_05_183955_add_more_fields_to_users_table', 1),
(218, '2019_12_06_174904_add_change_return_label_column_to_invoice_layouts_table', 1),
(219, '2019_12_11_121307_add_draft_and_quotation_list_permissions', 1),
(220, '2019_12_12_180126_copy_expense_total_to_total_before_tax', 1),
(221, '2019_12_19_181412_make_alert_quantity_field_nullable_on_products_table', 1),
(222, '2019_12_25_173413_create_dashboard_configurations_table', 1),
(223, '2020_01_08_133506_create_document_and_notes_table', 1),
(224, '2020_01_09_113252_add_cc_bcc_column_to_notification_templates_table', 1),
(225, '2020_01_16_174818_add_round_off_amount_field_to_transactions_table', 1),
(226, '2020_01_28_162345_add_weighing_scale_settings_in_business_settings_table', 1),
(227, '2020_02_18_172447_add_import_fields_to_transactions_table', 1),
(228, '2020_03_13_135844_add_is_active_column_to_selling_price_groups_table', 1),
(229, '2020_03_16_115449_add_contact_status_field_to_contacts_table', 1),
(230, '2020_03_26_124736_add_allow_login_column_in_users_table', 1),
(231, '2020_04_13_154150_add_feature_products_column_to_business_loactions', 1),
(232, '2020_04_15_151802_add_user_type_to_users_table', 1),
(233, '2020_04_22_153905_add_subscription_repeat_on_column_to_transactions_table', 1),
(234, '2020_04_28_111436_add_shipping_address_to_contacts_table', 1),
(235, '2020_06_01_094654_add_max_sale_discount_column_to_users_table', 1),
(236, '2020_06_12_162245_modify_contacts_table', 1),
(237, '2020_06_22_103104_change_recur_interval_default_to_one', 1),
(238, '2020_07_09_174621_add_balance_field_to_contacts_table', 1),
(239, '2020_07_23_104933_change_status_column_to_varchar_in_transaction_table', 1),
(240, '2020_09_07_171059_change_completed_stock_transfer_status_to_final', 1),
(241, '2020_09_21_123224_modify_booking_status_column_in_bookings_table', 1),
(242, '2020_09_22_121639_create_discount_variations_table', 1),
(243, '2020_10_05_121550_modify_business_location_table_for_invoice_layout', 1),
(244, '2020_10_16_175726_set_status_as_received_for_opening_stock', 1),
(245, '2020_10_23_170823_add_for_group_tax_column_to_tax_rates_table', 1),
(246, '2020_11_04_130940_add_more_custom_fields_to_contacts_table', 1),
(247, '2020_11_10_152841_add_cash_register_permissions', 1),
(248, '2020_11_17_164041_modify_type_column_to_varchar_in_contacts_table', 1),
(249, '2020_12_18_181447_add_shipping_custom_fields_to_transactions_table', 1),
(250, '2020_12_22_164303_add_sub_status_column_to_transactions_table', 1),
(251, '2020_12_24_153050_add_custom_fields_to_transactions_table', 1),
(252, '2020_12_28_105403_add_whatsapp_text_column_to_notification_templates_table', 1),
(253, '2020_12_29_165925_add_model_document_type_to_media_table', 1),
(254, '2021_02_08_175632_add_contact_number_fields_to_users_table', 1),
(255, '2021_02_11_172217_add_indexing_for_multiple_columns', 1),
(256, '2021_02_23_122043_add_more_columns_to_customer_groups_table', 1),
(257, '2021_02_24_175551_add_print_invoice_permission_to_all_roles', 1),
(258, '2021_03_03_162021_add_purchase_order_columns_to_purchase_lines_and_transactions_table', 1),
(259, '2021_03_11_120229_add_sales_order_columns', 1),
(260, '2021_03_16_120705_add_business_id_to_activity_log_table', 1),
(261, '2021_03_16_153427_add_code_columns_to_business_table', 1),
(262, '2021_03_18_173308_add_account_details_column_to_accounts_table', 1),
(263, '2021_03_18_183119_add_prefer_payment_account_columns_to_transactions_table', 1),
(264, '2021_03_22_120810_add_more_types_of_service_custom_fields', 1),
(265, '2021_03_24_183132_add_shipping_export_custom_field_details_to_contacts_table', 1),
(266, '2021_03_25_170715_add_export_custom_fields_info_to_transactions_table', 1),
(267, '2021_04_15_063449_add_denominations_column_to_cash_registers_table', 1),
(268, '2021_05_22_083426_add_indexing_to_account_transactions_table', 1),
(269, '2021_07_08_065808_add_additional_expense_columns_to_transaction_table', 1),
(270, '2021_07_13_082918_add_qr_code_columns_to_invoice_layouts_table', 1),
(271, '2021_07_21_061615_add_fields_to_show_commission_agent_in_invoice_layout', 1),
(272, '2021_08_13_105549_add_crm_contact_id_to_users_table', 1),
(273, '2021_08_25_114932_add_payment_link_fields_to_transaction_payments_table', 1),
(274, '2021_09_01_063110_add_spg_column_to_discounts_table', 1),
(275, '2021_09_03_061528_modify_cash_register_transactions_table', 1),
(276, '2021_10_05_061658_add_source_column_to_transactions_table', 1),
(277, '2021_12_16_121851_add_parent_id_column_to_expense_categories_table', 1),
(278, '2022_04_14_075120_add_payment_type_column_to_transaction_payments_table', 1),
(279, '2022_04_21_083327_create_cash_denominations_table', 1),
(280, '2022_05_10_055307_add_delivery_date_column_to_transactions_table', 1),
(281, '2022_06_13_123135_add_currency_precision_and_quantity_precision_fields_to_business_table', 1),
(282, '2022_06_28_133342_add_secondary_unit_columns_to_products_sell_line_purchase_lines_tables', 1),
(283, '2022_07_13_114307_create_purchase_requisition_related_columns', 1),
(284, '2022_08_25_132707_add_service_staff_timer_fields_to_products_and_users_table', 1),
(285, '2014_10_12_100000_create_password_reset_tokens_table', 2),
(286, '2019_08_19_000000_create_failed_jobs_table', 2),
(287, '2019_12_14_000001_create_personal_access_tokens_table', 2),
(288, '2023_11_12_033158_create_equel_bonus_user_to_places_table', 2),
(289, '2024_08_07_072709_create_referrals_table', 3),
(290, '2024_08_07_092333_add_referrer_id_to_custom_users_table', 4),
(291, '2024_08_11_165759_create_balance_sheets_table', 5),
(292, '2024_08_27_143830_create_withdraw_requests_table', 6),
(293, '2024_09_17_075357_create_notices_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `mlm_volumes`
--

CREATE TABLE `mlm_volumes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `left_leg_volume` decimal(15,2) DEFAULT 0.00,
  `right_leg_volume` decimal(15,2) DEFAULT 0.00,
  `left_leg_carried_over` decimal(15,2) DEFAULT 0.00,
  `right_leg_carried_over` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mlm_volumes`
--

INSERT INTO `mlm_volumes` (`id`, `user_id`, `left_leg_volume`, `right_leg_volume`, `left_leg_carried_over`, `right_leg_carried_over`, `created_at`, `updated_at`) VALUES
(10, 133, 0.00, 0.00, 350.00, 1150.00, '2024-09-24 00:15:34', '2024-09-24 00:28:50'),
(11, 121, 0.00, 0.00, 175.00, 675.00, '2024-09-24 00:18:56', '2024-09-24 00:28:50'),
(12, 132, 0.00, 0.00, 0.00, 175.00, '2024-09-24 00:19:27', '2024-09-24 00:28:50'),
(13, 141, NULL, 0.00, 350.00, 0.00, '2024-09-24 00:22:08', '2024-09-24 00:22:08'),
(14, 139, NULL, 0.00, 350.00, 0.00, '2024-09-24 00:22:08', '2024-09-24 00:22:08'),
(15, 138, NULL, 0.00, 350.00, 0.00, '2024-09-24 00:22:08', '2024-09-24 00:22:08'),
(16, 136, 0.00, 0.00, 350.00, 0.00, '2024-09-24 00:22:08', '2024-09-24 00:28:51'),
(17, 137, 0.00, 0.00, 675.00, 0.00, '2024-09-24 00:22:52', '2024-09-24 00:28:51'),
(18, 146, NULL, 0.00, 300.00, 0.00, '2024-09-24 00:25:50', '2024-09-24 00:25:50'),
(19, 145, NULL, NULL, 300.00, 175.00, '2024-09-24 00:25:50', '2024-09-24 00:26:25'),
(20, 144, 0.00, 0.00, 475.00, 0.00, '2024-09-24 00:25:50', '2024-09-24 00:28:51'),
(21, 156, 0.00, NULL, 0.00, 175.00, '2024-09-24 00:26:25', '2024-09-24 00:26:25');

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_permissions`
--

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
(80, 'App\\User', 2),
(80, 'App\\User', 12),
(80, 'App\\User', 16),
(80, 'App\\User', 20),
(112, 'App\\User', 17),
(112, 'App\\User', 21);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 1),
(2, 'App\\User', 2),
(4, 'App\\User', 16),
(4, 'App\\User', 20),
(5, 'App\\User', 12),
(5, 'App\\User', 17),
(5, 'App\\User', 21);

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `notice_for` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`notice_for`)),
  `start_from` timestamp NULL DEFAULT NULL,
  `end_to` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`id`, `content`, `notice_for`, `start_from`, `end_to`, `created_at`, `updated_at`) VALUES
(2, 'New Notice', '[\"user\",\"stockiest\",\"depo\"]', '2024-09-14 18:00:00', '2024-10-15 18:00:00', '2024-09-17 03:30:27', '2024-09-17 03:48:11'),
(3, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '[\"user\",\"stockiest\",\"depo\"]', '2024-09-02 18:00:00', '2024-09-26 18:00:00', '2024-09-17 03:54:21', '2024-09-17 04:05:33');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(191) NOT NULL,
  `notifiable_type` varchar(191) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `template_for` varchar(191) NOT NULL,
  `email_body` text DEFAULT NULL,
  `sms_body` text DEFAULT NULL,
  `whatsapp_text` text DEFAULT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `cc` varchar(191) DEFAULT NULL,
  `bcc` varchar(191) DEFAULT NULL,
  `auto_send` tinyint(1) NOT NULL DEFAULT 0,
  `auto_send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `auto_send_wa_notif` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `business_id`, `template_for`, `email_body`, `sms_body`, `whatsapp_text`, `subject`, `cc`, `bcc`, `auto_send`, `auto_send_sms`, `auto_send_wa_notif`, `created_at`, `updated_at`) VALUES
(1, 1, 'new_sale', '<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {received_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', NULL, 'Thank you from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(2, 1, 'payment_received', '<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {received_amount}</p>\n\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {received_amount}. {business_name}', NULL, 'Payment Received, from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(3, 1, 'payment_reminder', '<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', NULL, 'Payment Reminder, from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(4, 1, 'new_booking', '<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', NULL, 'Booking Confirmed - {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(5, 1, 'new_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible. {business_name}', NULL, 'New Order, from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(6, 1, 'payment_paid', '<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {order_ref_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {order_ref_number}.\n                    Kindly note it down. {business_name}', NULL, 'Payment Paid, from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(7, 1, 'items_received', '<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {order_ref_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have received all items from invoice reference number {order_ref_number}. Thank you for processing it. {business_name}', NULL, 'Items received, from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(8, 1, 'items_pending', '<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {order_ref_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {order_ref_number} . Please process it as soon as possible.{business_name}', NULL, 'Items Pending, from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(9, 1, 'new_quotation', '<p>Dear {contact_name},</p>\n\n                    <p>Your quotation number is {invoice_number}<br />\n                    Total amount: {total_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', NULL, 'Thank you from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(10, 1, 'purchase_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new purchase order with reference number {order_ref_number}. The respective invoice is attached here with.</p>\n\n                    <p>{business_logo}</p>', 'We have a new purchase order with reference number {order_ref_number}. {business_name}', NULL, 'New Purchase Order, from {business_name}', NULL, NULL, 0, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `secret` varchar(100) NOT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_invoice`
--

CREATE TABLE `order_invoice` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `quantity` varchar(255) DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) NOT NULL,
  `product_ids` varchar(255) DEFAULT NULL,
  `product_prices` varchar(255) DEFAULT NULL,
  `pvs` varchar(255) DEFAULT NULL,
  `quantitys` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oreders_table`
--

CREATE TABLE `oreders_table` (
  `id` bigint(20) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `product_price` int(11) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `payment_option` varchar(255) DEFAULT NULL,
  `paid_status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `c_user_id` bigint(20) UNSIGNED NOT NULL,
  `bkash` varchar(255) DEFAULT NULL,
  `nagad` varchar(255) DEFAULT NULL,
  `rocket` varchar(255) DEFAULT NULL,
  `b_name` varchar(255) DEFAULT NULL,
  `b_branch` varchar(255) DEFAULT NULL,
  `b_route` varchar(255) DEFAULT NULL,
  `b_swift` varchar(191) DEFAULT NULL,
  `b_account_name` varchar(255) DEFAULT NULL,
  `b_account` varchar(255) DEFAULT NULL,
  `user_type` varchar(191) NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_gateways`
--

INSERT INTO `payment_gateways` (`id`, `c_user_id`, `bkash`, `nagad`, `rocket`, `b_name`, `b_branch`, `b_route`, `b_swift`, `b_account_name`, `b_account`, `user_type`, `created_at`, `updated_at`) VALUES
(1, 3, '+8801911314145', '+8801911314145', '+8801911314145', 'the city bank ltd', 'gulshan', '2341', '', '3993939 Rais', '93993939', 'user', '2024-07-10 23:25:29', '2024-07-10 23:25:29'),
(2, 121, '01732379393', '01914565237', '017323793934', 'Dutch Bangla Bank Limited', 'Mirpur', '123456', 'DBBL19', 'MD. SHAWN SHIKDER SONET', '123456789101542', 'user', '2024-09-05 06:07:31', '2024-09-06 00:00:41'),
(3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user', '2024-09-09 11:24:50', '2024-09-09 11:24:50'),
(4, 1, '01732379392', '01914565232', '017323793932', 'Shonali Bank Limited', 'Mirpur', '123456', 'SBPL19', 'Mr. Stockiest', '12345678910100', 'stockiest', '2024-09-10 07:00:09', '2024-09-10 07:05:24'),
(5, 139, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user', '2024-09-13 04:03:46', '2024-09-13 04:03:46');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'profit_loss_report.view', 'web', '2023-02-23 21:56:17', NULL),
(2, 'direct_sell.access', 'web', '2023-02-23 21:56:17', NULL),
(3, 'product.opening_stock', 'web', '2023-02-23 21:56:22', '2023-02-23 21:56:22'),
(4, 'crud_all_bookings', 'web', '2023-02-23 21:56:25', '2023-02-23 21:56:25'),
(5, 'crud_own_bookings', 'web', '2023-02-23 21:56:25', '2023-02-23 21:56:25'),
(6, 'access_default_selling_price', 'web', '2023-02-23 21:56:27', '2023-02-23 21:56:27'),
(7, 'purchase.payments', 'web', '2023-02-23 21:56:28', '2023-02-23 21:56:28'),
(8, 'sell.payments', 'web', '2023-02-23 21:56:28', '2023-02-23 21:56:28'),
(9, 'edit_product_price_from_sale_screen', 'web', '2023-02-23 21:56:29', '2023-02-23 21:56:29'),
(10, 'edit_product_discount_from_sale_screen', 'web', '2023-02-23 21:56:29', '2023-02-23 21:56:29'),
(11, 'roles.view', 'web', '2023-02-23 21:56:29', '2023-02-23 21:56:29'),
(12, 'roles.create', 'web', '2023-02-23 21:56:29', '2023-02-23 21:56:29'),
(13, 'roles.update', 'web', '2023-02-23 21:56:29', '2023-02-23 21:56:29'),
(14, 'roles.delete', 'web', '2023-02-23 21:56:29', '2023-02-23 21:56:29'),
(15, 'account.access', 'web', '2023-02-23 21:56:31', '2023-02-23 21:56:31'),
(16, 'discount.access', 'web', '2023-02-23 21:56:31', '2023-02-23 21:56:31'),
(17, 'view_purchase_price', 'web', '2023-02-23 21:56:33', '2023-02-23 21:56:33'),
(18, 'view_own_sell_only', 'web', '2023-02-23 21:56:33', '2023-02-23 21:56:33'),
(19, 'edit_product_discount_from_pos_screen', 'web', '2023-02-23 21:56:34', '2023-02-23 21:56:34'),
(20, 'edit_product_price_from_pos_screen', 'web', '2023-02-23 21:56:34', '2023-02-23 21:56:34'),
(21, 'access_shipping', 'web', '2023-02-23 21:56:36', '2023-02-23 21:56:36'),
(22, 'purchase.update_status', 'web', '2023-02-23 21:56:36', '2023-02-23 21:56:36'),
(23, 'list_drafts', 'web', '2023-02-23 21:56:37', '2023-02-23 21:56:37'),
(24, 'list_quotations', 'web', '2023-02-23 21:56:37', '2023-02-23 21:56:37'),
(25, 'view_cash_register', 'web', '2023-02-23 21:56:40', '2023-02-23 21:56:40'),
(26, 'close_cash_register', 'web', '2023-02-23 21:56:40', '2023-02-23 21:56:40'),
(27, 'print_invoice', 'web', '2023-02-23 21:56:42', '2023-02-23 21:56:42'),
(28, 'user.view', 'web', '2023-02-23 21:56:47', NULL),
(29, 'user.create', 'web', '2023-02-23 21:56:47', NULL),
(30, 'user.update', 'web', '2023-02-23 21:56:47', NULL),
(31, 'user.delete', 'web', '2023-02-23 21:56:47', NULL),
(32, 'supplier.view', 'web', '2023-02-23 21:56:47', NULL),
(33, 'supplier.create', 'web', '2023-02-23 21:56:47', NULL),
(34, 'supplier.update', 'web', '2023-02-23 21:56:47', NULL),
(35, 'supplier.delete', 'web', '2023-02-23 21:56:47', NULL),
(36, 'customer.view', 'web', '2023-02-23 21:56:47', NULL),
(37, 'customer.create', 'web', '2023-02-23 21:56:47', NULL),
(38, 'customer.update', 'web', '2023-02-23 21:56:47', NULL),
(39, 'customer.delete', 'web', '2023-02-23 21:56:47', NULL),
(40, 'product.view', 'web', '2023-02-23 21:56:47', NULL),
(41, 'product.create', 'web', '2023-02-23 21:56:47', NULL),
(42, 'product.update', 'web', '2023-02-23 21:56:47', NULL),
(43, 'product.delete', 'web', '2023-02-23 21:56:47', NULL),
(44, 'purchase.view', 'web', '2023-02-23 21:56:47', NULL),
(45, 'purchase.create', 'web', '2023-02-23 21:56:47', NULL),
(46, 'purchase.update', 'web', '2023-02-23 21:56:47', NULL),
(47, 'purchase.delete', 'web', '2023-02-23 21:56:47', NULL),
(48, 'sell.view', 'web', '2023-02-23 21:56:47', NULL),
(49, 'sell.create', 'web', '2023-02-23 21:56:47', NULL),
(50, 'sell.update', 'web', '2023-02-23 21:56:47', NULL),
(51, 'sell.delete', 'web', '2023-02-23 21:56:47', NULL),
(52, 'purchase_n_sell_report.view', 'web', '2023-02-23 21:56:47', NULL),
(53, 'contacts_report.view', 'web', '2023-02-23 21:56:47', NULL),
(54, 'stock_report.view', 'web', '2023-02-23 21:56:47', NULL),
(55, 'tax_report.view', 'web', '2023-02-23 21:56:47', NULL),
(56, 'trending_product_report.view', 'web', '2023-02-23 21:56:47', NULL),
(57, 'register_report.view', 'web', '2023-02-23 21:56:47', NULL),
(58, 'sales_representative.view', 'web', '2023-02-23 21:56:47', NULL),
(59, 'expense_report.view', 'web', '2023-02-23 21:56:47', NULL),
(60, 'business_settings.access', 'web', '2023-02-23 21:56:47', NULL),
(61, 'barcode_settings.access', 'web', '2023-02-23 21:56:47', NULL),
(62, 'invoice_settings.access', 'web', '2023-02-23 21:56:47', NULL),
(63, 'brand.view', 'web', '2023-02-23 21:56:47', NULL),
(64, 'brand.create', 'web', '2023-02-23 21:56:47', NULL),
(65, 'brand.update', 'web', '2023-02-23 21:56:47', NULL),
(66, 'brand.delete', 'web', '2023-02-23 21:56:47', NULL),
(67, 'tax_rate.view', 'web', '2023-02-23 21:56:47', NULL),
(68, 'tax_rate.create', 'web', '2023-02-23 21:56:47', NULL),
(69, 'tax_rate.update', 'web', '2023-02-23 21:56:47', NULL),
(70, 'tax_rate.delete', 'web', '2023-02-23 21:56:47', NULL),
(71, 'unit.view', 'web', '2023-02-23 21:56:47', NULL),
(72, 'unit.create', 'web', '2023-02-23 21:56:47', NULL),
(73, 'unit.update', 'web', '2023-02-23 21:56:47', NULL),
(74, 'unit.delete', 'web', '2023-02-23 21:56:47', NULL),
(75, 'category.view', 'web', '2023-02-23 21:56:47', NULL),
(76, 'category.create', 'web', '2023-02-23 21:56:47', NULL),
(77, 'category.update', 'web', '2023-02-23 21:56:47', NULL),
(78, 'category.delete', 'web', '2023-02-23 21:56:47', NULL),
(79, 'expense.access', 'web', '2023-02-23 21:56:47', NULL),
(80, 'access_all_locations', 'web', '2023-02-23 21:56:47', NULL),
(81, 'dashboard.data', 'web', '2023-02-23 21:56:47', NULL),
(82, 'location.1', 'web', '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(83, 'view_paid_sells_only', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(84, 'view_due_sells_only', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(85, 'view_partial_sells_only', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(86, 'view_overdue_sells_only', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(87, 'direct_sell.update', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(88, 'direct_sell.delete', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(89, 'view_commission_agent_sell', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(90, 'edit_sell_payment', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(91, 'delete_sell_payment', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(92, 'access_types_of_service', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(93, 'access_sell_return', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(94, 'access_own_sell_return', 'web', '2023-09-01 06:27:18', '2023-09-01 06:27:18'),
(95, 'edit_invoice_number', 'web', '2023-09-01 06:27:19', '2023-09-01 06:27:19'),
(96, 'view_product_stock_value', 'web', '2023-09-01 06:33:01', '2023-09-01 06:33:01'),
(97, 'expense.add', 'web', '2023-09-01 06:33:01', '2023-09-01 06:33:01'),
(98, 'expense.edit', 'web', '2023-09-01 06:33:01', '2023-09-01 06:33:01'),
(99, 'expense.delete', 'web', '2023-09-01 06:33:01', '2023-09-01 06:33:01'),
(100, 'customer.view_own', 'web', '2023-09-01 06:33:01', '2023-09-01 06:33:01'),
(101, 'customer_irrespective_of_sell', 'web', '2023-09-01 06:33:02', '2023-09-01 06:33:02'),
(102, 'view_own_expense', 'web', '2023-09-01 06:33:02', '2023-09-01 06:33:02'),
(103, 'draft.view_own', 'web', '2023-09-03 16:37:55', '2023-09-03 16:37:55'),
(104, 'draft.update', 'web', '2023-09-18 16:09:05', '2023-09-18 16:09:05'),
(105, 'edit_purchase_payment', 'web', '2023-12-12 18:37:55', '2023-12-12 18:37:55'),
(106, 'delete_purchase_payment', 'web', '2023-12-12 18:37:55', '2023-12-12 18:37:55'),
(107, 'view_own_purchase', 'web', '2023-12-12 18:37:55', '2023-12-12 18:37:55'),
(108, 'access_pending_shipments_only', 'web', '2023-12-12 18:40:15', '2023-12-12 18:40:15'),
(109, 'access_commission_agent_shipping', 'web', '2023-12-12 18:40:15', '2023-12-12 18:40:15'),
(110, 'access_own_shipping', 'web', '2023-12-12 18:40:15', '2023-12-12 18:40:15'),
(111, 'location.2', 'web', '2023-12-13 02:11:28', '2023-12-13 02:11:28'),
(112, 'location.3', 'web', '2023-12-13 15:50:40', '2023-12-13 15:50:40'),
(113, 'supplier.view_own', 'web', '2024-02-03 02:36:38', '2024-02-03 02:36:38');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `printers`
--

CREATE TABLE `printers` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `connection_type` enum('network','windows','linux') NOT NULL,
  `capability_profile` enum('default','simple','SP2000','TEP-200M','P822D') NOT NULL DEFAULT 'default',
  `char_per_line` varchar(191) DEFAULT NULL,
  `ip_address` varchar(191) DEFAULT NULL,
  `port` varchar(191) DEFAULT NULL,
  `path` varchar(191) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `type` enum('single','variable','modifier','combo') DEFAULT NULL,
  `unit_id` int(10) UNSIGNED DEFAULT NULL,
  `secondary_unit_id` int(11) DEFAULT NULL,
  `sub_unit_ids` text DEFAULT NULL,
  `brand_id` int(10) UNSIGNED DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `sub_category_id` int(10) UNSIGNED DEFAULT NULL,
  `tax` int(10) UNSIGNED DEFAULT NULL,
  `tax_type` enum('inclusive','exclusive') NOT NULL,
  `enable_stock` tinyint(1) NOT NULL DEFAULT 0,
  `alert_quantity` decimal(22,4) DEFAULT NULL,
  `sku` varchar(191) NOT NULL,
  `barcode_type` enum('C39','C128','EAN13','EAN8','UPCA','UPCE') DEFAULT 'C128',
  `expiry_period` decimal(4,2) DEFAULT NULL,
  `expiry_period_type` enum('days','months') DEFAULT NULL,
  `enable_sr_no` tinyint(1) NOT NULL DEFAULT 0,
  `weight` varchar(191) DEFAULT NULL,
  `product_custom_field1` varchar(191) DEFAULT NULL,
  `product_custom_field2` varchar(191) DEFAULT NULL,
  `product_custom_field3` varchar(191) DEFAULT NULL,
  `product_custom_field4` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `product_description` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `preparation_time_in_minutes` int(11) DEFAULT NULL,
  `warranty_id` int(11) DEFAULT NULL,
  `is_inactive` tinyint(1) NOT NULL DEFAULT 0,
  `not_for_selling` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `business_id`, `type`, `unit_id`, `secondary_unit_id`, `sub_unit_ids`, `brand_id`, `category_id`, `sub_category_id`, `tax`, `tax_type`, `enable_stock`, `alert_quantity`, `sku`, `barcode_type`, `expiry_period`, `expiry_period_type`, `enable_sr_no`, `weight`, `product_custom_field1`, `product_custom_field2`, `product_custom_field3`, `product_custom_field4`, `image`, `product_description`, `created_by`, `preparation_time_in_minutes`, `warranty_id`, `is_inactive`, `not_for_selling`, `created_at`, `updated_at`) VALUES
(461, 'Ergoliv 200 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0085', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055187_1705852154_1693235562_1690341978_Syrup5.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(462, 'Ergoliv 450 ml Syp.', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0086', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055187_1705852154_1693235563_1690342013_Syrup5.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(463, 'S-Clean 120 gm', 1, 'single', 5, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0087', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055187_1705852154_1693235563_1690342992_Powder1.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(464, 'Ergozim Syp 200 ml', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0088', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055187_1705852154_1693235563_1690341624_Syrup7.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(465, 'Ergozim Syp 450 ml.', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0089', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852154_1693235563_1690341662_Syrup7.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(466, 'E-Opi 30 Cap', 1, 'single', 2, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0090', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852154_1693235563_1690342256_Capsule4.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(467, 'E-Opi 100 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 100.0000, '10035733', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852155_1693235563_1690342189_Capsule4.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(468, 'Ermet 200 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0093', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852155_1693235563_1690342153_Syrup14.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(469, 'Anpile 450 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '45057731', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852155_1693235563_1690342734_Syrup1.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(470, 'Ergo Fort Syp. 450 ml', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0095', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852155_1693235563_1690341554_Syrup4.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(471, 'Ergovit  Plus 30 Pcs tab', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '0096', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852155_1693235563_1690341919_Capsule6.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(472, 'Hemofresh 200 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '0097', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852155_1693235563_1690351532_homo%252520fresh.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(473, 'Hemofresh 450 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '0098', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055188_1705852155_1693235563_1690351323_homo%252520fresh.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(474, 'Babicon 100 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '0099', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235563_1690351259_baby%252520con.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(475, 'Ergo Ging', 1, 'single', 2, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '03048733', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235563_1690341378_Capsule12.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(476, 'E-Green 30 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '0101', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235564_1690304007_E-green.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(477, 'E-GB-60 30 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '30640733', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235564_1690342116_Capsule2.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(478, 'Ergo Nip 20 Tab.', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0103', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235564_1690341436_Tablet2.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(479, 'Etonip 30 Tab', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '0104', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235564_1690342507_Tablet3.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(480, 'Max Join 30 cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '0105', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235564_1690351497_maxjoin.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(481, 'Max Bone-D 30 cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '30063730', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1702034077_Capsule9.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(482, 'Max Bone-D 30 pot', 1, 'single', 2, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0107', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235564_1690351615_max%252520bon.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(483, 'Ergopec 100 Ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 6.0000, '0108', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235564_1690341829_Syrup6.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(484, 'Ergopec 200 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0109', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852155_1693235564_1690341861_Syrup6.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(485, 'Azma Care 30 Tab', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '0110', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055189_1705852156_1693235564_1690342941_Tablet1.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(486, 'Azma Care 30 pot', 1, 'single', 2, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0111', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235564_1690342876_Tablet1.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(487, 'Vivion 200 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0112', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235564_1690351203_vivion.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(488, 'Vivion 450 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0113', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235564_1690343728_Syrup13.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(489, 'Luconil 200 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 4.0000, '0114', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235564_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(490, 'Mestron 200 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '0115', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_1690351447_mestron.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(491, 'Ero Lina 30 Cap.', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '0116', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_1690342663_Capsule7.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(492, 'Soyamix 150 gm', 1, 'single', 2, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0117', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(493, 'Cardocare 450ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '45054730', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_1690342806_Syrup3.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(494, 'Night Ex 20 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0119', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_1690343585_Capsule11.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(495, 'Ergo Restore 20 pcs cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0120', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_1690341505_Capsule5.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(496, 'Penoil 10 ml', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0121', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_1690343640_Others1.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(497, 'Libiton 200 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 4.0000, '0122', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_1690351562_liviton.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(498, 'Libiton 450 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '0123', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055190_1705852156_1693235565_1690351373_liviton.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(499, 'Tox Clean 450 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '45056734', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852156_1693235565_1690343060_Syrup12.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(500, 'Etadin 30 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '0125', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852156_1693235565_1690342430_Capsule8.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(501, 'Hepa Cure 20 cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0126', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852156_1693235565_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(502, 'Prosta Care 20 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0127', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852157_1693235565_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(503, 'Meno CR-40 20 cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0128', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852157_1693235565_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(504, 'Al Quit 20 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0129', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852157_1693235565_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(505, 'Ergo Free 20 Pcs cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0130', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(506, 'E-Luco 20 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 30.0000, '0131', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(507, 'Cure Feb 50 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 3.0000, '0132', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(508, 'Cure Feb 100 ml Syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '780405000000', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055191_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(509, 'Memo Fresh 200 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0135', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055192_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(510, 'Feb-X 10 Cap', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 10.0000, '0136', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055192_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(511, 'Memo Fresh 100 ml syp', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 5.0000, '0137', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055192_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(512, 'Moli-10 20 tab', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 20.0000, '0138', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055192_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(513, 'Dento Care Herbal Toothpaste) ??? ?????', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0139', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055192_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(514, 'Glory Beauti Soap 100 gm', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0140', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055192_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(515, 'Glory Ganodema Soao 125 gm', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0141', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055192_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(516, 'Acnil Anti Acne Sop 100 gm', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0142', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055192_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(517, 'Anti Dandruff Ketoconazol 75 gm', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'inclusive', 1, 2.0000, '0144', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055193_1705852157_1693235566_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(518, 'Dicare 30 pcs', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'exclusive', 1, 150.0000, '30050731', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055193_1705852157_1702015885_Capsule1.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(519, 'Teer Atta 1 kg', 1, 'single', 3, NULL, NULL, 14, 12, NULL, NULL, 'exclusive', 1, 5.0000, '1421622110', 'C128', NULL, NULL, 0, '1 kg', '', '', '', '', '1721055193_1705852158_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(520, 'Teer Atta 2 kg', 1, 'single', 3, NULL, NULL, 14, 12, NULL, NULL, 'exclusive', 1, 3.0000, '1421622112', 'C128', NULL, NULL, 0, '2 kg', '', '', '', '', '1721055193_1705852158_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(521, 'Teer Moyda 1 kg', 1, 'single', 3, NULL, NULL, 14, 12, NULL, NULL, 'exclusive', 1, 5.0000, '1433623610', 'C128', NULL, NULL, 0, '1 kg', '', '', '', '', '1721055193_1705852158_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(522, 'Teer Suji 500 gm', 1, 'single', 4, NULL, NULL, 14, 12, NULL, NULL, 'exclusive', 1, 5.0000, '1439624404', 'C128', NULL, NULL, 0, '500 gm', '', '', '', '', '1721055193_1705852158_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(523, 'Teer Lobon 1 kg', 1, 'single', 3, NULL, NULL, 14, 12, NULL, NULL, 'exclusive', 1, 5.0000, '1751622610', 'C128', NULL, NULL, 0, '1 kg', '', '', '', '', '1721055193_1705852158_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(524, 'Teer Soyabin Tel 1 Lit.', 1, 'single', 3, NULL, NULL, 14, 12, NULL, NULL, 'exclusive', 1, 5.0000, '1254615910', 'C128', NULL, NULL, 0, '1000 lit.', '', '', '', '', '1721055193_1705852159_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(525, 'Teer Soyabin Tel 2 Lit.', 1, 'single', 3, NULL, NULL, 14, 12, NULL, NULL, 'exclusive', 1, 4.0000, '1254615912', 'C128', NULL, NULL, 0, '2000 lit.', '', '', '', '', '1721055193_1705852159_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(526, 'Teer Soyabin Tel 5 Lit.', 1, 'single', 3, NULL, NULL, 14, 12, NULL, NULL, 'exclusive', 1, 2.0000, '1254615923', 'C128', NULL, NULL, 0, '5 lit.', '', '', '', '', '1721055194_1705852159_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(527, 'Dicare 60 pcs pot', 1, 'single', 2, NULL, NULL, 32, 4, NULL, NULL, 'exclusive', 1, 5.0000, '60050731', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055194_1705852160_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(528, 'Himsagor oil 100 ml', 1, 'single', 1, NULL, NULL, 32, 4, NULL, NULL, 'exclusive', 1, 2.0000, '0186', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055194_1705852160_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(529, 'Allright oil 200 ml', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 2.0000, '0187', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055194_1705852160_1702015329_Allright%2520oil.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(530, 'Pain Cure 30 Cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 0.0000, '0188', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055194_1705852160_1702034124_Pain%2520Cure%2520tab.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(531, 'Actual Cal 30 Cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 2.0000, '0189', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055194_1705852160_1702015434_Acual%2520Cal.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(532, 'Piles Guard 60 Tab', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 2.0000, '0190', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055195_1705852160_1702016189_piles%2520Guard.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(533, 'Fit & Smart 30 tab', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0191', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055195_1705852160_1702016084_Fit%2520smart.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(534, 'Lungs Reviver 120 gm', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0192', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055195_1705852160_1702016309_Lungs%2520revier.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(535, 'Actual omega 30 cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0193', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055195_1705852160_1702015713_Acual%2520Omega.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(536, 'RISE UP 400 gm', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0194', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055196_1705852160_1702034222_Rise%2520Up.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(537, 'Tarino 30 tab', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0195', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055196_1705852160_1702037804_Freash%2520Tarino.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(538, 'Spirulina 30 cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0196', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055197_1705852160_1702034352_Sprilina%2520Tab.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(539, 'Antiflu 30 tab', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0197', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055197_1705852160_1702037558_Anti%2520Flue.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(540, 'Tox nil 30 tab', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0198', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055197_1705852160_1702034662_Tox%2520Nil%2520tab.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(541, 'Slimming meal', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0199', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055197_1705852160_1702038026_Sliming.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(542, 'Gluco Shield', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0200', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055197_1705852160_1702034876_Gluco%2520Shieli%2520Pwr.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(543, 'Gluco Shield 30 cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0201', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702034896_Gluco%2520Shieli%2520Tab.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(544, 'Urine controler 30 cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0202', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702034392_urine%2520controll.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(545, 'Active Women 60 cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0203', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702015592_Active%2520women.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(546, 'Cardio custody 400 gm', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0204', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702034470_Cardio.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(547, 'X Win 20 tab', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0205', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702034594_X%2520win%2520tab.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(548, 'X Win Saset 15 pkt', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 15.0000, '0206', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702034636_X%2520win%2520sajjet.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(549, 'Actual magic oil 30 ml', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0207', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702015544_Majik%2520oil.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(550, 'Cardio custody 200 gm', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0208', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702034492_Cardio.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(551, 'Actual Gano Moringa 30 cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0209', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055198_1705852161_1702015511_Gano%2520moringa.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(552, 'Anti Thynocap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0210', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055199_1705852161_1702037532_Anty%2520Thiocape.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(553, 'Leva cool', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0211', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055199_1705852161_1702037936_Livacool.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(554, 'Rena Clean', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0212', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055199_1705852161_1702037991_Rena%2520clean.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(555, 'Bone  h 30 cap', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0213', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055199_1705852161_1702037591_bone%2520h.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(556, 'Ominash masala', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0214', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055199_1705852161_1702016495_Ominash%2520Masala.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(557, 'Levo Clean', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0215', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055199_1705852161_1702037887_Livo%2520clean.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(558, 'Femoriz', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0216', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055199_1705852161_1702037740_Fimorise.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(559, 'Peurilin', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0217', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055200_1705852161_1702038094_Purilin%25202.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(560, 'Allergy Relief', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0218', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055200_1705852162_1702037229_allejy%2520Relif.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(561, 'Parajel oil', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0260', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055200_1705852164_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(562, 'Liquid', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0261', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055200_1705852164_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(563, 'Soya Energy 400 gm', 1, 'single', 2, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0266', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055200_1705852164_1702034439_Soya%2520Energy.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(564, 'Actual moringa juice 150 gm', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0267', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055200_1705852164_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(565, 'Actual allovera shampu 200 ml', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0268', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055200_1705852164_1702015380_Allovera%2520Shampu.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(566, 'Dentolin tooth 50 gm', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0269', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055201_1705852164_1702037344_Dentol.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(567, 'Action Toothpaste 150 gm', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0270', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055201_1705852164_1702038194_Action%2520Tootpest.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(568, 'Actual Neem Soap 100 gm', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0271', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055201_1705852164_1702038173_Neem%2520Saop.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(569, 'Toxnil sachets 15 s', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 3.0000, '0279', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055201_1705852165_1702034687_tox%2520nil%2520sajet.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(570, 'Aloevera Face wash 50 ml.', 1, 'single', 1, NULL, NULL, 25, 5, NULL, NULL, 'exclusive', 1, 1.0000, '0280', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055201_1705852165_1702015756_Allovera%2520Facewash.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(571, 'Ren kear 30 cap', 1, 'single', 2, NULL, NULL, 32, 4, NULL, NULL, 'exclusive', 1, 1.0000, '0281', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055201_1705852165_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(572, 'Neuro- Ex 30 cap', 1, 'single', 2, NULL, NULL, 32, 4, NULL, NULL, 'exclusive', 1, 1.0000, '0282', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055201_1705852165_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(573, 'Eyefood  200 gm pow.', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0295', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055202_1705852166_1702037619_Eye%2520food.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(574, 'Vitality plus 400 gm pow', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0296', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055202_1705852166_1702034732_Vitalin.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(575, 'Spirulina juice powder 400 gm', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0297', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055202_1705852166_1702034311_Spirulina%2520juce%2520pwr.jpg', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(576, 'Chini gura Rice 1 Kg', 1, 'single', 3, NULL, NULL, 14, 6, NULL, NULL, 'exclusive', 1, 2.0000, '1841626210', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055202_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(577, 'Musur dal 1 Kg', 1, 'single', 3, NULL, NULL, 14, 6, NULL, NULL, 'exclusive', 1, 2.0000, '3050625010', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055202_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(578, 'Anjeber 400 ml', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 2.0000, '0300', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055202_1705852166_1702351578_Anjeba.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(579, 'Actual Soy Choco powder 400 gm', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0301', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055203_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(580, 'Ginkgo Biloba 30 pcs', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0302', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055203_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(581, 'Omacure 60 pcs', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0303', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055203_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(582, 'Fresgen 30 pcs', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0304', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055203_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(583, 'B-17 60 Pcs', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0305', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055203_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(584, 'Blood Booster 30 pcs', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0307', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055203_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(585, 'Ultra Power Bulum 15 gm', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 2.0000, '0308', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055203_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(586, 'Renal food', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0309', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055203_1705852166_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(587, 'Nephro Cap', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 2.0000, '0310', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055204_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(588, 'Actual Brightenning Oil', 1, 'single', 2, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0311', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055204_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(589, 'Boss Hair Oil 100 ml', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0312', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055204_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(590, 'Aloe & Care 20 gm', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0313', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055204_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(591, 'Actual Turmeric soap 100 gm', 1, 'single', 1, NULL, NULL, 25, NULL, NULL, NULL, 'exclusive', 1, 1.0000, '0314', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055204_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(592, 'Actual Masrum soap 100 gm', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0315', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055204_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(593, 'Actual Aloevera soap 100 gm', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0316', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055204_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(594, 'Actual Neem Honey soap 100 gm', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0317', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055205_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(595, 'Cucumber Whitening Soap 100 gm', 1, 'single', 1, NULL, NULL, 25, 14, NULL, NULL, 'exclusive', 1, 1.0000, '0318', 'C128', NULL, NULL, 0, '', '', '', '', '', '1721055205_1705852167_default.png', NULL, 1, NULL, NULL, 0, 0, '2024-07-15 20:53:27', '2024-07-15 20:53:27');

-- --------------------------------------------------------

--
-- Table structure for table `product_locations`
--

CREATE TABLE `product_locations` (
  `product_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_racks`
--

CREATE TABLE `product_racks` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `rack` varchar(191) DEFAULT NULL,
  `row` varchar(191) DEFAULT NULL,
  `position` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variations`
--

CREATE TABLE `product_variations` (
  `id` int(10) UNSIGNED NOT NULL,
  `variation_template_id` int(11) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `is_dummy` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variations`
--

INSERT INTO `product_variations` (`id`, `variation_template_id`, `name`, `product_id`, `is_dummy`, `created_at`, `updated_at`) VALUES
(231, NULL, 'DUMMY', 461, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(232, NULL, 'DUMMY', 462, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(233, NULL, 'DUMMY', 463, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(234, NULL, 'DUMMY', 464, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(235, NULL, 'DUMMY', 465, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(236, NULL, 'DUMMY', 466, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(237, NULL, 'DUMMY', 467, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(238, NULL, 'DUMMY', 468, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(239, NULL, 'DUMMY', 469, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(240, NULL, 'DUMMY', 470, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(241, NULL, 'DUMMY', 471, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(242, NULL, 'DUMMY', 472, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(243, NULL, 'DUMMY', 473, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(244, NULL, 'DUMMY', 474, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(245, NULL, 'DUMMY', 475, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(246, NULL, 'DUMMY', 476, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(247, NULL, 'DUMMY', 477, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(248, NULL, 'DUMMY', 478, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(249, NULL, 'DUMMY', 479, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(250, NULL, 'DUMMY', 480, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(251, NULL, 'DUMMY', 481, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(252, NULL, 'DUMMY', 482, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(253, NULL, 'DUMMY', 483, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(254, NULL, 'DUMMY', 484, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(255, NULL, 'DUMMY', 485, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(256, NULL, 'DUMMY', 486, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(257, NULL, 'DUMMY', 487, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(258, NULL, 'DUMMY', 488, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(259, NULL, 'DUMMY', 489, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(260, NULL, 'DUMMY', 490, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(261, NULL, 'DUMMY', 491, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(262, NULL, 'DUMMY', 492, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(263, NULL, 'DUMMY', 493, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(264, NULL, 'DUMMY', 494, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(265, NULL, 'DUMMY', 495, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(266, NULL, 'DUMMY', 496, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(267, NULL, 'DUMMY', 497, 1, '2024-07-15 20:53:25', '2024-07-15 20:53:25'),
(268, NULL, 'DUMMY', 498, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(269, NULL, 'DUMMY', 499, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(270, NULL, 'DUMMY', 500, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(271, NULL, 'DUMMY', 501, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(272, NULL, 'DUMMY', 502, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(273, NULL, 'DUMMY', 503, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(274, NULL, 'DUMMY', 504, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(275, NULL, 'DUMMY', 505, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(276, NULL, 'DUMMY', 506, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(277, NULL, 'DUMMY', 507, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(278, NULL, 'DUMMY', 508, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(279, NULL, 'DUMMY', 509, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(280, NULL, 'DUMMY', 510, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(281, NULL, 'DUMMY', 511, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(282, NULL, 'DUMMY', 512, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(283, NULL, 'DUMMY', 513, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(284, NULL, 'DUMMY', 514, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(285, NULL, 'DUMMY', 515, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(286, NULL, 'DUMMY', 516, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(287, NULL, 'DUMMY', 517, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(288, NULL, 'DUMMY', 518, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(289, NULL, 'DUMMY', 519, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(290, NULL, 'DUMMY', 520, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(291, NULL, 'DUMMY', 521, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(292, NULL, 'DUMMY', 522, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(293, NULL, 'DUMMY', 523, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(294, NULL, 'DUMMY', 524, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(295, NULL, 'DUMMY', 525, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(296, NULL, 'DUMMY', 526, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(297, NULL, 'DUMMY', 527, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(298, NULL, 'DUMMY', 528, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(299, NULL, 'DUMMY', 529, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(300, NULL, 'DUMMY', 530, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(301, NULL, 'DUMMY', 531, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(302, NULL, 'DUMMY', 532, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(303, NULL, 'DUMMY', 533, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(304, NULL, 'DUMMY', 534, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(305, NULL, 'DUMMY', 535, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(306, NULL, 'DUMMY', 536, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(307, NULL, 'DUMMY', 537, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(308, NULL, 'DUMMY', 538, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(309, NULL, 'DUMMY', 539, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(310, NULL, 'DUMMY', 540, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(311, NULL, 'DUMMY', 541, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(312, NULL, 'DUMMY', 542, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(313, NULL, 'DUMMY', 543, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(314, NULL, 'DUMMY', 544, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(315, NULL, 'DUMMY', 545, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(316, NULL, 'DUMMY', 546, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(317, NULL, 'DUMMY', 547, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(318, NULL, 'DUMMY', 548, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(319, NULL, 'DUMMY', 549, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(320, NULL, 'DUMMY', 550, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(321, NULL, 'DUMMY', 551, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(322, NULL, 'DUMMY', 552, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(323, NULL, 'DUMMY', 553, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(324, NULL, 'DUMMY', 554, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(325, NULL, 'DUMMY', 555, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(326, NULL, 'DUMMY', 556, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(327, NULL, 'DUMMY', 557, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(328, NULL, 'DUMMY', 558, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(329, NULL, 'DUMMY', 559, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(330, NULL, 'DUMMY', 560, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(331, NULL, 'DUMMY', 561, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(332, NULL, 'DUMMY', 562, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(333, NULL, 'DUMMY', 563, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(334, NULL, 'DUMMY', 564, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(335, NULL, 'DUMMY', 565, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(336, NULL, 'DUMMY', 566, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(337, NULL, 'DUMMY', 567, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(338, NULL, 'DUMMY', 568, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(339, NULL, 'DUMMY', 569, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(340, NULL, 'DUMMY', 570, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(341, NULL, 'DUMMY', 571, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(342, NULL, 'DUMMY', 572, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(343, NULL, 'DUMMY', 573, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(344, NULL, 'DUMMY', 574, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(345, NULL, 'DUMMY', 575, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(346, NULL, 'DUMMY', 576, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(347, NULL, 'DUMMY', 577, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(348, NULL, 'DUMMY', 578, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(349, NULL, 'DUMMY', 579, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(350, NULL, 'DUMMY', 580, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(351, NULL, 'DUMMY', 581, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(352, NULL, 'DUMMY', 582, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(353, NULL, 'DUMMY', 583, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(354, NULL, 'DUMMY', 584, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(355, NULL, 'DUMMY', 585, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(356, NULL, 'DUMMY', 586, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(357, NULL, 'DUMMY', 587, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(358, NULL, 'DUMMY', 588, 1, '2024-07-15 20:53:26', '2024-07-15 20:53:26'),
(359, NULL, 'DUMMY', 589, 1, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(360, NULL, 'DUMMY', 590, 1, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(361, NULL, 'DUMMY', 591, 1, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(362, NULL, 'DUMMY', 592, 1, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(363, NULL, 'DUMMY', 593, 1, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(364, NULL, 'DUMMY', 594, 1, '2024-07-15 20:53:27', '2024-07-15 20:53:27'),
(365, NULL, 'DUMMY', 595, 1, '2024-07-15 20:53:27', '2024-07-15 20:53:27');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_lines`
--

CREATE TABLE `purchase_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `secondary_unit_quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `pp_without_discount` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Purchase price before inline discounts',
  `discount_percent` decimal(5,2) NOT NULL DEFAULT 0.00 COMMENT 'Inline discount percentage',
  `purchase_price` decimal(22,4) NOT NULL,
  `purchase_price_inc_tax` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `purchase_requisition_line_id` int(11) DEFAULT NULL,
  `purchase_order_line_id` int(11) DEFAULT NULL,
  `quantity_sold` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Quanity sold from this purchase line',
  `quantity_adjusted` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Quanity adjusted in stock adjustment from this purchase line',
  `quantity_returned` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `po_quantity_purchased` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `mfg_quantity_used` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `mfg_date` date DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `lot_number` varchar(191) DEFAULT NULL,
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_lines`
--

INSERT INTO `purchase_lines` (`id`, `transaction_id`, `product_id`, `variation_id`, `quantity`, `secondary_unit_quantity`, `pp_without_discount`, `discount_percent`, `purchase_price`, `purchase_price_inc_tax`, `item_tax`, `tax_id`, `purchase_requisition_line_id`, `purchase_order_line_id`, `quantity_sold`, `quantity_adjusted`, `quantity_returned`, `po_quantity_purchased`, `mfg_quantity_used`, `mfg_date`, `exp_date`, `lot_number`, `sub_unit_id`, `created_at`, `updated_at`) VALUES
(1, 1, 58, 58, 1328.0000, 0.0000, 10.3300, 0.00, 10.3300, 10.3300, 0.0000, NULL, NULL, NULL, 1061.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-06-14 01:02:15'),
(2, 1, 98, 98, 1.0000, 0.0000, 620.0000, 0.00, 620.0000, 620.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(3, 1, 23, 23, 78.0000, 0.0000, 55.0000, 0.00, 55.0000, 55.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(4, 1, 6, 6, 15.0000, 0.0000, 225.0000, 0.00, 225.0000, 225.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(5, 1, 33, 33, 9.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 9.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-05-11 22:03:27'),
(6, 1, 24, 24, 74.0000, 0.0000, 105.0000, 0.00, 105.0000, 105.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(7, 1, 31, 31, 1290.0000, 0.0000, 14.6700, 0.00, 14.6700, 14.6700, 0.0000, NULL, NULL, NULL, 1290.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-26 16:07:28'),
(8, 1, 21, 21, 848.0000, 0.0000, 14.0000, 0.00, 14.0000, 14.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(9, 1, 19, 19, 144.0000, 0.0000, 20.0000, 0.00, 20.0000, 20.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(10, 1, 20, 20, 58.0000, 0.0000, 18.3300, 0.00, 18.3300, 18.3300, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(11, 1, 25, 25, 262.0000, 0.0000, 10.5000, 0.00, 10.5000, 10.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(12, 1, 7, 7, 2026.0000, 0.0000, 7.5000, 0.00, 7.5000, 7.5000, 0.0000, NULL, NULL, NULL, 3.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-07-13 23:28:05'),
(13, 1, 44, 44, 609.0000, 0.0000, 12.5000, 0.00, 12.5000, 12.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(14, 1, 18, 18, 80.0000, 0.0000, 10.5000, 0.00, 10.5000, 10.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(15, 1, 40, 40, 129.0000, 0.0000, 30.0000, 0.00, 30.0000, 30.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(16, 1, 34, 34, 60.0000, 0.0000, 17.5000, 0.00, 17.5000, 17.5000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-04-03 02:38:26'),
(17, 1, 35, 35, 20.0000, 0.0000, 37.5000, 0.00, 37.5000, 37.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(18, 1, 30, 30, 11.0000, 0.0000, 180.0000, 0.00, 180.0000, 180.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(19, 1, 29, 29, 6.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(20, 1, 45, 45, 60.0000, 0.0000, 16.5000, 0.00, 16.5000, 16.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(21, 1, 2, 2, 13.0000, 0.0000, 190.0000, 0.00, 190.0000, 190.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(22, 1, 10, 10, 19.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(23, 1, 38, 38, 5.0000, 0.0000, 400.0000, 0.00, 400.0000, 400.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(24, 1, 37, 37, 13.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(25, 1, 4, 4, 35.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(26, 1, 1, 1, 27.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(27, 1, 39, 39, 65.0000, 0.0000, 275.0000, 0.00, 275.0000, 275.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(28, 1, 13, 13, 35.0000, 0.0000, 280.0000, 0.00, 280.0000, 280.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(29, 1, 27, 27, 46.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(30, 1, 28, 28, 13.0000, 0.0000, 190.0000, 0.00, 190.0000, 190.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(31, 1, 5, 5, 31.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(32, 1, 14, 14, 33.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(33, 1, 48, 48, 5.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(34, 1, 49, 49, 8.0000, 0.0000, 470.0000, 0.00, 470.0000, 470.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(35, 1, 15, 15, 11.0000, 0.0000, 600.0000, 0.00, 600.0000, 600.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(36, 1, 3, 3, 3.0000, 0.0000, 625.0000, 0.00, 625.0000, 625.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(37, 1, 194, 194, 3.0000, 0.0000, 840.0000, 0.00, 840.0000, 840.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(38, 1, 195, 195, 1.0000, 0.0000, 420.0000, 0.00, 420.0000, 420.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(39, 1, 36, 36, 5.0000, 0.0000, 160.0000, 0.00, 160.0000, 160.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(40, 1, 41, 41, 80.0000, 0.0000, 52.0000, 0.00, 52.0000, 52.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(41, 1, 8, 8, 9.0000, 0.0000, 540.0000, 0.00, 540.0000, 540.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(42, 1, 9, 9, 16.0000, 0.0000, 300.0000, 0.00, 300.0000, 300.0000, 0.0000, NULL, NULL, NULL, 5.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-07-13 23:26:17'),
(43, 1, 17, 17, 180.0000, 0.0000, 15.3400, 0.00, 15.3400, 15.3400, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-24 02:43:59', '2024-01-24 02:45:37'),
(44, 3, 183, 183, 4.0000, 0.0000, 280.0000, 0.00, 280.0000, 280.0000, 0.0000, NULL, NULL, NULL, 4.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:40', '2024-02-14 17:25:19'),
(45, 3, 181, 181, 4.0000, 0.0000, 350.0000, 0.00, 350.0000, 350.0000, 0.0000, NULL, NULL, NULL, 4.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:40', '2024-03-18 03:55:01'),
(46, 3, 184, 184, 15.0000, 0.0000, 123.0000, 0.00, 123.0000, 123.0000, 0.0000, NULL, NULL, NULL, 8.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:40', '2024-06-14 01:43:48'),
(47, 3, 224, 224, 1.0000, 0.0000, 525.0000, 0.00, 525.0000, 525.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:40', '2024-07-13 23:27:37'),
(48, 3, 128, 128, 3.0000, 0.0000, 770.0000, 0.00, 770.0000, 770.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:40', '2024-01-26 03:57:40'),
(49, 3, 104, 104, 4.0000, 0.0000, 770.0000, 0.00, 770.0000, 770.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:40', '2024-01-26 03:57:40'),
(50, 3, 180, 180, 3.0000, 0.0000, 280.0000, 0.00, 280.0000, 280.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(51, 3, 100, 100, 3.0000, 0.0000, 490.0000, 0.00, 490.0000, 490.0000, 0.0000, NULL, NULL, NULL, 3.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-07-13 23:26:17'),
(52, 3, 182, 182, 6.0000, 0.0000, 198.0000, 0.00, 198.0000, 198.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(53, 3, 108, 108, 4.0000, 0.0000, 665.0000, 0.00, 665.0000, 665.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(54, 3, 122, 122, 2.0000, 0.0000, 735.0000, 0.00, 735.0000, 735.0000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-06-13 23:59:14'),
(55, 3, 214, 214, 1.0000, 0.0000, 2100.0000, 0.00, 2100.0000, 2100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(56, 3, 112, 112, 5.0000, 0.0000, 630.0000, 0.00, 630.0000, 630.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(57, 3, 105, 105, 3.0000, 0.0000, 875.0000, 0.00, 875.0000, 875.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(58, 3, 120, 120, 2.0000, 0.0000, 585.0000, 0.00, 585.0000, 585.0000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-06-02 19:42:34'),
(59, 3, 173, 173, 6.0000, 0.0000, 1080.0000, 0.00, 1080.0000, 1080.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(60, 3, 118, 118, 3.0000, 0.0000, 665.0000, 0.00, 665.0000, 665.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(61, 3, 223, 223, 2.0000, 0.0000, 420.0000, 0.00, 420.0000, 420.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(62, 3, 207, 207, 3.0000, 0.0000, 805.0000, 0.00, 805.0000, 805.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(63, 3, 121, 121, 4.0000, 0.0000, 770.0000, 0.00, 770.0000, 770.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(64, 3, 117, 117, 2.0000, 0.0000, 1400.0000, 0.00, 1400.0000, 1400.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-06-14 01:13:57'),
(65, 3, 119, 119, 75.0000, 0.0000, 42.0000, 0.00, 42.0000, 42.0000, 0.0000, NULL, NULL, NULL, 8.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-04-03 02:41:50'),
(66, 3, 179, 179, 1.0000, 0.0000, 630.0000, 0.00, 630.0000, 630.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(67, 3, 216, 216, 1.0000, 0.0000, 2100.0000, 0.00, 2100.0000, 2100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(68, 3, 212, 212, 1.0000, 0.0000, 665.0000, 0.00, 665.0000, 665.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(69, 3, 101, 101, 5.0000, 0.0000, 525.0000, 0.00, 525.0000, 525.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(70, 3, 109, 109, 12.0000, 0.0000, 350.0000, 0.00, 350.0000, 350.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(71, 3, 211, 211, 2.0000, 0.0000, 1050.0000, 0.00, 1050.0000, 1050.0000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-06-14 01:02:15'),
(72, 3, 125, 125, 5.0000, 0.0000, 1120.0000, 0.00, 1120.0000, 1120.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(73, 3, 124, 124, 3.0000, 0.0000, 770.0000, 0.00, 770.0000, 770.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(74, 3, 106, 106, 8.0000, 0.0000, 980.0000, 0.00, 980.0000, 980.0000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-06-13 23:50:48'),
(75, 3, 129, 129, 4.0000, 0.0000, 630.0000, 0.00, 630.0000, 630.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(76, 3, 103, 103, 3.0000, 0.0000, 700.0000, 0.00, 700.0000, 700.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(77, 3, 123, 123, 3.0000, 0.0000, 892.0000, 0.00, 892.0000, 892.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(78, 3, 114, 114, 5.0000, 0.0000, 560.0000, 0.00, 560.0000, 560.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(79, 3, 107, 107, 4.0000, 0.0000, 665.0000, 0.00, 665.0000, 665.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(80, 3, 222, 222, 2.0000, 0.0000, 336.0000, 0.00, 336.0000, 336.0000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-02-13 01:57:04'),
(81, 3, 111, 111, 5.0000, 0.0000, 525.0000, 0.00, 525.0000, 525.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(82, 3, 127, 127, 2.0000, 0.0000, 450.0000, 0.00, 450.0000, 450.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(83, 3, 126, 126, 6.0000, 0.0000, 700.0000, 0.00, 700.0000, 700.0000, 0.0000, NULL, NULL, NULL, 6.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-05-11 22:03:27'),
(84, 3, 130, 130, 3.0000, 0.0000, 630.0000, 0.00, 630.0000, 630.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(85, 3, 219, 219, 6.0000, 0.0000, 245.0000, 0.00, 245.0000, 245.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(86, 3, 131, 131, 7.0000, 0.0000, 665.0000, 0.00, 665.0000, 665.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(87, 3, 218, 218, 1.0000, 0.0000, 1220.0000, 0.00, 1220.0000, 1220.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(88, 3, 215, 215, 2.0000, 0.0000, 980.0000, 0.00, 980.0000, 980.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(89, 3, 102, 102, 3.0000, 0.0000, 595.0000, 0.00, 595.0000, 595.0000, 0.0000, NULL, NULL, NULL, 3.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-06-13 23:50:48'),
(90, 3, 221, 221, 1.0000, 0.0000, 805.0000, 0.00, 805.0000, 805.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(91, 3, 213, 213, 3.0000, 0.0000, 682.0000, 0.00, 682.0000, 682.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(92, 3, 220, 220, 3.0000, 0.0000, 700.0000, 0.00, 700.0000, 700.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(93, 3, 113, 113, 1.0000, 0.0000, 1125.0000, 0.00, 1125.0000, 1125.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(94, 3, 228, 228, 5.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(95, 3, 225, 225, 4.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(96, 3, 226, 226, 5.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(97, 3, 227, 227, 6.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 4.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-06-03 22:46:06'),
(98, 3, 229, 229, 6.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(99, 3, 192, 192, 32.0000, 0.0000, 32.6700, 0.00, 32.6700, 32.6700, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(100, 3, 110, 110, 2.0000, 0.0000, 350.0000, 0.00, 350.0000, 350.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-06-14 00:54:51'),
(101, 3, 206, 206, 3.0000, 0.0000, 945.0000, 0.00, 945.0000, 945.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 03:57:41', '2024-01-26 03:57:41'),
(102, 4, 133, 133, 14.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(103, 4, 134, 134, 7.0000, 0.0000, 125.0000, 0.00, 125.0000, 125.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(104, 4, 135, 135, 1.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(105, 4, 136, 136, 1.0000, 0.0000, 160.0000, 0.00, 160.0000, 160.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(106, 4, 160, 160, 5.0000, 0.0000, 110.0000, 0.00, 110.0000, 110.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(107, 4, 203, 203, 3.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(108, 4, 202, 202, 3.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(109, 4, 144, 144, 34.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(110, 4, 156, 156, 1.0000, 0.0000, 210.0000, 0.00, 210.0000, 210.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(111, 4, 146, 146, 14.0000, 0.0000, 22.0000, 0.00, 22.0000, 22.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(112, 4, 201, 201, 23.0000, 0.0000, 10.0000, 0.00, 10.0000, 10.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(113, 4, 142, 142, 22.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-04-03 02:38:26'),
(114, 4, 145, 145, 17.0000, 0.0000, 55.0000, 0.00, 55.0000, 55.0000, 0.0000, NULL, NULL, NULL, 4.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-05-11 21:58:43'),
(115, 4, 69, 69, 6.0000, 0.0000, 50.0000, 0.00, 50.0000, 50.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(116, 4, 34, 34, 4.0000, 0.0000, 17.5000, 0.00, 17.5000, 17.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(117, 4, 163, 163, 5.0000, 0.0000, 400.0000, 0.00, 400.0000, 400.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(118, 4, 96, 96, 12.0000, 0.0000, 52.0000, 0.00, 52.0000, 52.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(119, 4, 157, 157, 1.0000, 0.0000, 270.0000, 0.00, 270.0000, 270.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(120, 4, 99, 99, 2.0000, 0.0000, 275.0000, 0.00, 275.0000, 275.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(121, 4, 158, 158, 4.0000, 0.0000, 270.0000, 0.00, 270.0000, 270.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(122, 4, 172, 172, 2.0000, 0.0000, 300.0000, 0.00, 300.0000, 300.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(123, 4, 171, 171, 2.0000, 0.0000, 300.0000, 0.00, 300.0000, 300.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(124, 4, 148, 148, 4.0000, 0.0000, 220.0000, 0.00, 220.0000, 220.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(125, 4, 147, 147, 6.0000, 0.0000, 120.0000, 0.00, 120.0000, 120.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(126, 4, 185, 185, 3.0000, 0.0000, 40.0000, 0.00, 40.0000, 40.0000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-03-28 17:29:22'),
(127, 4, 141, 141, 7.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(128, 4, 138, 138, 1.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(129, 4, 139, 139, 1.0000, 0.0000, 130.0000, 0.00, 130.0000, 130.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(130, 4, 204, 204, 2.0000, 0.0000, 250.0000, 0.00, 250.0000, 250.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(131, 4, 151, 151, 2.0000, 0.0000, 70.0000, 0.00, 70.0000, 70.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(132, 4, 152, 152, 2.0000, 0.0000, 160.0000, 0.00, 160.0000, 160.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 15:39:27', '2024-01-26 15:39:27'),
(133, 8, 31, 31, 1010.0000, 0.0000, 0.0000, 0.00, 14.6700, 14.6700, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 16:07:28', '2024-01-26 16:07:28'),
(134, 9, 74, 74, 1.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 21:14:49', '2024-01-26 21:14:49'),
(135, 9, 75, 75, 6.0000, 0.0000, 62.0000, 0.00, 62.0000, 62.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 21:14:49', '2024-01-26 21:14:49'),
(136, 9, 78, 78, 31.0000, 0.0000, 165.0000, 0.00, 165.0000, 165.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 21:14:49', '2024-01-26 21:14:49'),
(137, 9, 79, 79, 16.0000, 0.0000, 330.0000, 0.00, 330.0000, 330.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 21:14:49', '2024-01-26 21:14:49'),
(138, 9, 80, 80, 4.0000, 0.0000, 805.0000, 0.00, 805.0000, 805.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 21:14:49', '2024-01-26 21:14:49'),
(139, 9, 77, 77, 18.0000, 0.0000, 35.2000, 0.00, 35.2000, 35.2000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-01-26 21:14:49', '2024-01-26 21:14:49'),
(140, 12, 58, 58, 1000.0000, 0.0000, 0.0000, 0.00, 10.3300, 10.3300, 0.0000, NULL, NULL, NULL, 50.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-02 15:47:18', '2024-02-04 15:15:49'),
(141, 14, 58, 58, 10.0000, 0.0000, 0.0000, 0.00, 10.3300, 10.3300, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 02:29:45', '2024-02-03 02:29:45'),
(142, 15, 230, 230, 100.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 100.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 03:07:53', '2024-02-03 03:23:30'),
(143, 16, 230, 230, 200.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 03:12:10', '2024-02-03 03:12:10'),
(144, 18, 230, 230, 50.0000, 0.0000, 0.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 03:13:00', '2024-02-03 03:13:00'),
(145, 20, 230, 230, 50.0000, 0.0000, 0.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 03:15:38', '2024-02-03 03:15:38'),
(146, 22, 230, 230, 50.0000, 0.0000, 0.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 03:23:30', '2024-02-03 03:23:30'),
(147, 23, 196, 196, 64.0000, 0.0000, 22.5000, 0.00, 22.5000, 22.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 03:56:10', '2024-02-03 03:56:10'),
(148, 23, 198, 198, 14.0000, 0.0000, 56.0000, 0.00, 56.0000, 56.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 03:56:10', '2024-02-03 03:56:10'),
(149, 23, 199, 199, 6.0000, 0.0000, 112.0000, 0.00, 112.0000, 112.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-02-03 03:56:10', '2024-02-03 03:56:10'),
(150, 61, 286, 56, 0.0000, 0.0000, 300.0000, 0.00, 300.0000, 300.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-07-14 13:05:07', '2024-07-15 20:42:34'),
(151, 74, 516, 286, 1.0000, 0.0000, 195.0000, 0.00, 195.0000, 195.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-07-28 14:15:31', '2024-07-29 19:44:41'),
(152, 75, 516, 286, 100.0000, 0.0000, 195.0000, 0.00, 195.0000, 195.0000, 0.0000, NULL, NULL, NULL, 100.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-07-28 14:15:35', '2024-07-29 19:45:41'),
(153, 87, 516, 286, 50000.0000, 0.0000, 195.0000, 0.00, 195.0000, 195.0000, 0.0000, NULL, NULL, NULL, 14.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2024-08-01 15:03:20', '2024-08-01 16:40:46');

-- --------------------------------------------------------

--
-- Table structure for table `redeem__beneficiaries`
--

CREATE TABLE `redeem__beneficiaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rp_redeemed_id` bigint(20) UNSIGNED NOT NULL,
  `rp_beneficiary_id` bigint(20) UNSIGNED NOT NULL,
  `ref_level` int(11) DEFAULT NULL,
  `beneficiary_type` varchar(255) NOT NULL,
  `benifit_by` enum('admin','user','stockiest','depo') NOT NULL DEFAULT 'user',
  `amount` decimal(8,2) NOT NULL,
  `activate_type` enum('active','repurchase') NOT NULL,
  `cb_distribute` int(2) DEFAULT NULL,
  `gb_distribute` int(2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `redeem__beneficiaries`
--

INSERT INTO `redeem__beneficiaries` (`id`, `rp_redeemed_id`, `rp_beneficiary_id`, `ref_level`, `beneficiary_type`, `benifit_by`, `amount`, `activate_type`, `cb_distribute`, `gb_distribute`, `created_at`, `updated_at`) VALUES
(407, 42, 121, NULL, 'Purchase Bonus', 'user', 17.50, 'active', 1, 1, '2024-08-27 08:00:04', '2024-09-10 01:43:59'),
(408, 42, 121, NULL, 'Rank Reward Bonus', 'user', 17.50, 'active', 1, 1, '2024-08-27 08:00:04', '2024-09-10 01:43:59'),
(409, 42, 0, NULL, 'Captainship Bonus', 'admin', 0.00, 'active', NULL, NULL, '2024-08-27 08:00:04', '2024-08-27 08:00:04'),
(410, 42, 0, NULL, 'Guardianship Bonus', 'admin', 0.00, 'active', NULL, NULL, '2024-08-27 08:00:04', '2024-08-27 08:00:04'),
(411, 42, 121, NULL, 'After Death Allowance', 'user', 3.50, 'active', 1, 1, '2024-08-27 08:00:04', '2024-09-10 01:43:59'),
(412, 42, 121, NULL, 'Company Profit Share', 'user', 8.75, 'active', 1, 1, '2024-08-27 08:00:04', '2024-09-10 01:43:59'),
(413, 42, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'active', NULL, NULL, '2024-08-27 08:00:04', '2024-08-27 08:00:04'),
(414, 42, 111, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-08-27 08:00:04', '2024-08-27 08:00:04'),
(415, 42, 121, NULL, 'Depo Bonus', 'depo', 7.00, 'active', 1, 1, '2024-08-27 08:00:04', '2024-09-10 01:43:59'),
(416, 42, 121, NULL, 'Company Fund', 'admin', 12.25, 'active', 1, 1, '2024-08-27 08:00:04', '2024-09-10 01:43:59'),
(417, 43, 132, NULL, 'Purchase Bonus', 'user', 22.50, 'active', 1, 1, '2024-08-30 02:48:28', '2024-09-10 01:43:59'),
(418, 43, 121, NULL, 'Creating Bonus', 'user', 22.50, 'active', 1, 1, '2024-08-30 02:48:28', '2024-09-10 01:43:59'),
(419, 43, 121, 1, 'Refer Bonus', 'user', 6.75, 'active', 1, 1, '2024-08-30 02:48:28', '2024-09-10 01:43:59'),
(420, 43, 132, NULL, 'Rank Reward Bonus', 'user', 22.50, 'active', 1, 1, '2024-08-30 02:48:28', '2024-09-10 01:43:59'),
(421, 43, 0, NULL, 'Captainship Bonus', 'admin', 0.00, 'active', NULL, NULL, '2024-08-30 02:48:28', '2024-08-30 02:48:28'),
(422, 43, 0, NULL, 'Guardianship Bonus', 'admin', 0.00, 'active', NULL, NULL, '2024-08-30 02:48:28', '2024-08-30 02:48:28'),
(423, 43, 132, NULL, 'After Death Allowance', 'user', 4.50, 'active', 1, 1, '2024-08-30 02:48:28', '2024-09-10 01:43:59'),
(424, 43, 132, NULL, 'Company Profit Share', 'user', 11.25, 'active', 1, 1, '2024-08-30 02:48:28', '2024-09-10 01:43:59'),
(425, 43, 1, NULL, 'Stockiest Bonus', 'stockiest', 15.75, 'active', NULL, NULL, '2024-08-30 02:48:28', '2024-08-30 02:48:28'),
(426, 43, 111, NULL, 'Stockiest Refer Bonus', 'user', 4.50, 'active', NULL, NULL, '2024-08-30 02:48:28', '2024-08-30 02:48:28'),
(427, 43, 132, NULL, 'Depo Bonus', 'depo', 9.00, 'active', 1, 1, '2024-08-30 02:48:28', '2024-09-10 01:43:59'),
(428, 43, 132, NULL, 'Company Fund', 'admin', 15.75, 'active', 1, 1, '2024-08-30 02:48:28', '2024-09-10 01:43:59'),
(429, 44, 133, NULL, 'Purchase Bonus', 'user', 27.50, 'active', 1, 1, '2024-08-30 02:49:45', '2024-09-10 01:43:59'),
(430, 44, 121, NULL, 'Creating Bonus', 'user', 27.50, 'active', 1, 1, '2024-08-30 02:49:45', '2024-09-10 01:43:59'),
(431, 44, 121, 1, 'Refer Bonus', 'user', 8.25, 'active', 1, 1, '2024-08-30 02:49:45', '2024-09-10 01:43:59'),
(432, 44, 133, NULL, 'Rank Reward Bonus', 'user', 27.50, 'active', 1, 1, '2024-08-30 02:49:45', '2024-09-10 01:43:59'),
(433, 44, 0, NULL, 'Captainship Bonus', 'admin', 0.00, 'active', NULL, NULL, '2024-08-30 02:49:45', '2024-08-30 02:49:45'),
(434, 44, 0, NULL, 'Guardianship Bonus', 'admin', 0.00, 'active', NULL, NULL, '2024-08-30 02:49:45', '2024-08-30 02:49:45'),
(435, 44, 133, NULL, 'After Death Allowance', 'user', 5.50, 'active', 1, 1, '2024-08-30 02:49:45', '2024-09-10 01:43:59'),
(436, 44, 133, NULL, 'Company Profit Share', 'user', 13.75, 'active', 1, 1, '2024-08-30 02:49:45', '2024-09-10 01:43:59'),
(437, 44, 1, NULL, 'Stockiest Bonus', 'stockiest', 19.25, 'active', NULL, NULL, '2024-08-30 02:49:45', '2024-08-30 02:49:45'),
(438, 44, 111, NULL, 'Stockiest Refer Bonus', 'user', 5.50, 'active', NULL, NULL, '2024-08-30 02:49:45', '2024-08-30 02:49:45'),
(439, 44, 133, NULL, 'Depo Bonus', 'depo', 11.00, 'active', 1, 1, '2024-08-30 02:49:45', '2024-09-10 01:43:59'),
(440, 44, 133, NULL, 'Company Fund', 'admin', 19.25, 'active', 1, 1, '2024-08-30 02:49:45', '2024-09-10 01:43:59'),
(441, 45, 136, NULL, 'Purchase Bonus', 'user', 27.50, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(442, 45, 133, NULL, 'Creating Bonus', 'user', 27.50, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(443, 45, 133, 1, 'Refer Bonus', 'user', 8.25, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(444, 45, 121, 2, 'Refer Bonus', 'user', 5.50, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(445, 45, 136, NULL, 'Rank Reward Bonus', 'user', 27.50, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(446, 45, 0, NULL, 'Captainship Bonus', 'admin', 0.00, 'active', NULL, NULL, '2024-08-30 02:50:26', '2024-08-30 02:50:26'),
(447, 45, 0, NULL, 'Guardianship Bonus', 'admin', 0.00, 'active', NULL, NULL, '2024-08-30 02:50:26', '2024-08-30 02:50:26'),
(448, 45, 136, NULL, 'After Death Allowance', 'user', 5.50, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(449, 45, 136, NULL, 'Company Profit Share', 'user', 13.75, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(450, 45, 1, NULL, 'Stockiest Bonus', 'stockiest', 19.25, 'active', NULL, NULL, '2024-08-30 02:50:26', '2024-08-30 02:50:26'),
(451, 45, 111, NULL, 'Stockiest Refer Bonus', 'user', 5.50, 'active', NULL, NULL, '2024-08-30 02:50:26', '2024-08-30 02:50:26'),
(452, 45, 136, NULL, 'Depo Bonus', 'depo', 11.00, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(453, 45, 136, NULL, 'Company Fund', 'admin', 19.25, 'active', 1, 1, '2024-08-30 02:50:26', '2024-09-10 01:43:59'),
(455, 47, 121, NULL, 'Purchase Bonus', 'user', 82.50, 'repurchase', NULL, NULL, '2024-09-06 04:22:43', '2024-09-06 04:22:43'),
(456, 47, 1, NULL, 'Stockiest Bonus', 'stockiest', 19.25, 'repurchase', NULL, NULL, '2024-09-06 04:22:43', '2024-09-06 04:22:43'),
(457, 47, 121, NULL, 'Stockiest Refer Bonus', 'user', 5.50, 'repurchase', NULL, NULL, '2024-09-06 04:22:43', '2024-09-06 04:22:43'),
(458, 47, 0, NULL, 'Depo Bonus', 'depo', 11.00, 'repurchase', NULL, NULL, '2024-09-06 04:22:43', '2024-09-06 04:22:43'),
(459, 47, 0, NULL, 'Marketing Cost', 'admin', 13.75, 'repurchase', NULL, NULL, '2024-09-06 04:22:43', '2024-09-06 04:22:43'),
(460, 47, 0, NULL, 'House Rent', 'admin', 16.50, 'repurchase', NULL, NULL, '2024-09-06 04:22:43', '2024-09-06 04:22:43'),
(461, 47, 0, NULL, 'Currier Cost', 'admin', 11.00, 'repurchase', NULL, NULL, '2024-09-06 04:22:43', '2024-09-06 04:22:43'),
(462, 47, 0, NULL, 'Company Fund', 'admin', 19.25, 'repurchase', NULL, NULL, '2024-09-06 04:22:43', '2024-09-06 04:22:43'),
(468, 53, 121, NULL, 'Purchase Bonus', 'user', 105.00, 'repurchase', NULL, NULL, '2024-09-06 05:36:34', '2024-09-06 05:36:34'),
(469, 53, 1, NULL, 'Stockiest Bonus', 'stockiest', 24.50, 'repurchase', NULL, NULL, '2024-09-06 05:36:34', '2024-09-06 05:36:34'),
(470, 53, 121, NULL, 'Stockiest Refer Bonus', 'user', 7.00, 'repurchase', NULL, NULL, '2024-09-06 05:36:34', '2024-09-06 05:36:34'),
(471, 53, 1, NULL, 'Depo Bonus', 'depo', 14.00, 'repurchase', NULL, NULL, '2024-09-06 05:36:34', '2024-09-06 05:36:34'),
(472, 53, 0, NULL, 'Marketing Cost', 'admin', 17.50, 'repurchase', NULL, NULL, '2024-09-06 05:36:34', '2024-09-06 05:36:34'),
(473, 53, 0, NULL, 'House Rent', 'admin', 17.50, 'repurchase', NULL, NULL, '2024-09-06 05:36:34', '2024-09-06 05:36:34'),
(474, 53, 0, NULL, 'Currier Cost', 'admin', 7.00, 'repurchase', NULL, NULL, '2024-09-06 05:36:34', '2024-09-06 05:36:34'),
(475, 53, 0, NULL, 'Company Fund', 'admin', 24.50, 'repurchase', NULL, NULL, '2024-09-06 05:36:34', '2024-09-06 05:36:34'),
(476, 54, 121, NULL, 'Purchase Bonus', 'user', 52.50, 'repurchase', NULL, NULL, '2024-09-16 07:45:27', '2024-09-16 07:45:27'),
(477, 54, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'repurchase', NULL, NULL, '2024-09-16 07:45:27', '2024-09-16 07:45:27'),
(478, 54, 1, NULL, 'House Rent', 'stockiest', 8.75, 'repurchase', NULL, NULL, '2024-09-16 07:45:27', '2024-09-16 07:45:27'),
(479, 54, 1, NULL, 'Currier Cost', 'stockiest', 3.50, 'repurchase', NULL, NULL, '2024-09-16 07:45:27', '2024-09-16 07:45:27'),
(480, 54, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'repurchase', NULL, NULL, '2024-09-16 07:45:27', '2024-09-16 07:45:27'),
(481, 54, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'repurchase', NULL, NULL, '2024-09-16 07:45:27', '2024-09-16 07:45:27'),
(482, 54, 0, NULL, 'Marketing Cost', 'admin', 8.75, 'repurchase', NULL, NULL, '2024-09-16 07:45:27', '2024-09-16 07:45:27'),
(483, 54, 0, NULL, 'Company Fund', 'admin', 12.25, 'repurchase', NULL, NULL, '2024-09-16 07:45:27', '2024-09-16 07:45:27'),
(496, 56, 309, NULL, 'Purchase Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(497, 56, 134, NULL, 'Creating Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(498, 56, 134, 1, 'Refer Bonus', 'user', 2.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(499, 56, 132, 2, 'Refer Bonus', 'user', 6.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(500, 56, 121, 3, 'Refer Bonus', 'user', 4.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(501, 56, 309, NULL, 'Rank Reward Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(502, 56, 309, NULL, 'After Death Allowance', 'user', 4.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(503, 56, 309, NULL, 'Company Profit Share', 'user', 10.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(504, 56, 1, NULL, 'Stockiest Bonus', 'stockiest', 14.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(505, 56, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(506, 56, 1, NULL, 'Depo Bonus', 'depo', 8.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(507, 56, 309, NULL, 'Company Fund', 'admin', 14.00, 'active', NULL, NULL, '2024-09-18 01:30:11', '2024-09-18 01:30:11'),
(508, 57, 309, NULL, 'Purchase Bonus', 'user', 30.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(509, 57, 134, NULL, 'Creating Bonus', 'user', 30.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(510, 57, 134, 1, 'Refer Bonus', 'user', 3.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(511, 57, 132, 2, 'Refer Bonus', 'user', 9.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(512, 57, 121, 3, 'Refer Bonus', 'user', 6.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(513, 57, 309, NULL, 'Rank Reward Bonus', 'user', 30.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(514, 57, 309, NULL, 'After Death Allowance', 'user', 6.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(515, 57, 309, NULL, 'Company Profit Share', 'user', 15.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(516, 57, 1, NULL, 'Stockiest Bonus', 'stockiest', 21.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(517, 57, 121, NULL, 'Stockiest Refer Bonus', 'user', 6.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(518, 57, 1, NULL, 'Depo Bonus', 'depo', 12.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(519, 57, 309, NULL, 'Company Fund', 'admin', 21.00, 'active', NULL, NULL, '2024-09-18 01:34:41', '2024-09-18 01:34:41'),
(520, 58, 309, NULL, 'Purchase Bonus', 'user', 35.00, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(521, 58, 134, NULL, 'Creating Bonus', 'user', 35.00, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(522, 58, 134, 1, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(523, 58, 132, 2, 'Refer Bonus', 'user', 10.50, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(524, 58, 121, 3, 'Refer Bonus', 'user', 7.00, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(525, 58, 309, NULL, 'Rank Reward Bonus', 'user', 35.00, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(526, 58, 309, NULL, 'After Death Allowance', 'user', 7.00, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(527, 58, 309, NULL, 'Company Profit Share', 'user', 17.50, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(528, 58, 1, NULL, 'Stockiest Bonus', 'stockiest', 24.50, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(529, 58, 121, NULL, 'Stockiest Refer Bonus', 'user', 7.00, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(530, 58, 1, NULL, 'Depo Bonus', 'depo', 14.00, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(531, 58, 309, NULL, 'Company Fund', 'admin', 24.50, 'active', NULL, NULL, '2024-09-18 01:39:12', '2024-09-18 01:39:12'),
(532, 59, 309, NULL, 'Purchase Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(533, 59, 134, NULL, 'Creating Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(534, 59, 134, 1, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(535, 59, 132, 2, 'Refer Bonus', 'user', 5.25, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(536, 59, 121, 3, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(537, 59, 309, NULL, 'Rank Reward Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(538, 59, 309, NULL, 'After Death Allowance', 'user', 3.50, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(539, 59, 309, NULL, 'Company Profit Share', 'user', 8.75, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(540, 59, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(541, 59, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(542, 59, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(543, 59, 309, NULL, 'Company Fund', 'admin', 12.25, 'active', NULL, NULL, '2024-09-18 01:45:31', '2024-09-18 01:45:31'),
(544, 60, 309, NULL, 'Purchase Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(545, 60, 134, NULL, 'Creating Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(546, 60, 134, 1, 'Refer Bonus', 'user', 2.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(547, 60, 132, 2, 'Refer Bonus', 'user', 6.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(548, 60, 121, 3, 'Refer Bonus', 'user', 4.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(549, 60, 309, NULL, 'Rank Reward Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(550, 60, 309, NULL, 'After Death Allowance', 'user', 4.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(551, 60, 309, NULL, 'Company Profit Share', 'user', 10.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(552, 60, 1, NULL, 'Stockiest Bonus', 'stockiest', 14.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(553, 60, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(554, 60, 1, NULL, 'Depo Bonus', 'depo', 8.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(555, 60, 309, NULL, 'Company Fund', 'admin', 14.00, 'active', NULL, NULL, '2024-09-18 01:48:04', '2024-09-18 01:48:04'),
(556, 61, 309, NULL, 'Purchase Bonus', 'user', 90.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(557, 61, 134, NULL, 'Creating Bonus', 'user', 60.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(558, 61, 134, 1, 'Refer Bonus', 'user', 3.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(559, 61, 132, 2, 'Refer Bonus', 'user', 12.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(560, 61, 121, 3, 'Refer Bonus', 'user', 9.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(561, 61, 1, NULL, 'Stockiest Bonus', 'stockiest', 21.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(562, 61, 0, NULL, 'House Rent', 'admin', 15.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(563, 61, 0, NULL, 'Currier Cost', 'admin', 6.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(564, 61, 121, NULL, 'Stockiest Refer Bonus', 'user', 6.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(565, 61, 1, NULL, 'Depo Bonus', 'depo', 12.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(566, 61, 0, NULL, 'Marketing Cost', 'admin', 15.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(567, 61, 0, NULL, 'Company Fund', 'admin', 21.00, 'repurchase', NULL, NULL, '2024-09-18 01:49:19', '2024-09-18 01:49:19'),
(604, 65, 121, NULL, 'Purchase Bonus', 'user', 75.00, 'repurchase', NULL, NULL, '2024-09-18 02:10:45', '2024-09-18 02:10:45'),
(605, 65, 1, NULL, 'Stockiest Bonus', 'stockiest', 17.50, 'repurchase', NULL, NULL, '2024-09-18 02:10:45', '2024-09-18 02:10:45'),
(606, 65, 0, NULL, 'House Rent', 'admin', 12.50, 'repurchase', NULL, NULL, '2024-09-18 02:10:45', '2024-09-18 02:10:45'),
(607, 65, 0, NULL, 'Currier Cost', 'admin', 5.00, 'repurchase', NULL, NULL, '2024-09-18 02:10:45', '2024-09-18 02:10:45'),
(608, 65, 121, NULL, 'Stockiest Refer Bonus', 'user', 5.00, 'repurchase', NULL, NULL, '2024-09-18 02:10:45', '2024-09-18 02:10:45'),
(609, 65, 1, NULL, 'Depo Bonus', 'depo', 10.00, 'repurchase', NULL, NULL, '2024-09-18 02:10:45', '2024-09-18 02:10:45'),
(610, 65, 0, NULL, 'Marketing Cost', 'admin', 12.50, 'repurchase', NULL, NULL, '2024-09-18 02:10:45', '2024-09-18 02:10:45'),
(611, 65, 0, NULL, 'Company Fund', 'admin', 17.50, 'repurchase', NULL, NULL, '2024-09-18 02:10:45', '2024-09-18 02:10:45'),
(612, 66, 160, NULL, 'Purchase Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(613, 66, 143, NULL, 'Creating Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(614, 66, 143, 1, 'Refer Bonus', 'user', 4.75, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(615, 66, 142, 2, 'Refer Bonus', 'user', 14.25, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(616, 66, 140, 3, 'Refer Bonus', 'user', 9.50, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(617, 66, 139, 4, 'Refer Bonus', 'user', 9.50, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(618, 66, 138, 5, 'Refer Bonus', 'user', 4.75, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(619, 66, 136, 6, 'Refer Bonus', 'user', 2.38, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(620, 66, 133, 7, 'Refer Bonus', 'user', 2.38, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(621, 66, 160, NULL, 'Rank Reward Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(622, 66, 160, NULL, 'After Death Allowance', 'user', 9.50, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(623, 66, 160, NULL, 'Company Profit Share', 'user', 23.75, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(624, 66, 1, NULL, 'Stockiest Bonus', 'stockiest', 33.25, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(625, 66, 121, NULL, 'Stockiest Refer Bonus', 'user', 9.50, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(626, 66, 1, NULL, 'Depo Bonus', 'depo', 19.00, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(627, 66, 160, NULL, 'Company Fund', 'admin', 33.25, 'active', NULL, NULL, '2024-09-23 21:36:26', '2024-09-23 21:36:26'),
(628, 67, 145, NULL, 'Purchase Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(629, 67, 144, NULL, 'Creating Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(630, 67, 144, 1, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(631, 67, 137, 2, 'Refer Bonus', 'user', 5.25, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(632, 67, 133, 3, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(633, 67, 121, 4, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(634, 67, 145, NULL, 'Rank Reward Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(635, 67, 145, NULL, 'After Death Allowance', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(636, 67, 145, NULL, 'Company Profit Share', 'user', 8.75, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(637, 67, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(638, 67, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(639, 67, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(640, 67, 145, NULL, 'Company Fund', 'admin', 12.25, 'active', NULL, NULL, '2024-09-23 21:40:17', '2024-09-23 21:40:17'),
(641, 68, 132, NULL, 'Purchase Bonus', 'user', 52.50, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(642, 68, 121, NULL, 'Creating Bonus', 'user', 35.00, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(643, 68, 121, 1, 'Refer Bonus', 'user', 1.75, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(644, 68, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(645, 68, 0, NULL, 'House Rent', 'admin', 8.75, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(646, 68, 0, NULL, 'Currier Cost', 'admin', 3.50, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(647, 68, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(648, 68, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(649, 68, 0, NULL, 'Marketing Cost', 'admin', 8.75, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(650, 68, 0, NULL, 'Company Fund', 'admin', 12.25, 'repurchase', NULL, NULL, '2024-09-23 21:42:08', '2024-09-23 21:42:08'),
(651, 69, 121, NULL, 'Purchase Bonus', 'user', 67.50, 'repurchase', NULL, NULL, '2024-09-23 21:47:27', '2024-09-23 21:47:27'),
(652, 69, 1, NULL, 'Stockiest Bonus', 'stockiest', 15.75, 'repurchase', NULL, NULL, '2024-09-23 21:47:27', '2024-09-23 21:47:27'),
(653, 69, 0, NULL, 'House Rent', 'admin', 11.25, 'repurchase', NULL, NULL, '2024-09-23 21:47:27', '2024-09-23 21:47:27'),
(654, 69, 0, NULL, 'Currier Cost', 'admin', 4.50, 'repurchase', NULL, NULL, '2024-09-23 21:47:27', '2024-09-23 21:47:27'),
(655, 69, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.50, 'repurchase', NULL, NULL, '2024-09-23 21:47:27', '2024-09-23 21:47:27'),
(656, 69, 1, NULL, 'Depo Bonus', 'depo', 9.00, 'repurchase', NULL, NULL, '2024-09-23 21:47:27', '2024-09-23 21:47:27'),
(657, 69, 0, NULL, 'Marketing Cost', 'admin', 11.25, 'repurchase', NULL, NULL, '2024-09-23 21:47:27', '2024-09-23 21:47:27'),
(658, 69, 0, NULL, 'Company Fund', 'admin', 15.75, 'repurchase', NULL, NULL, '2024-09-23 21:47:27', '2024-09-23 21:47:27'),
(659, 70, 121, NULL, 'Purchase Bonus', 'user', 210.00, 'repurchase', NULL, NULL, '2024-09-23 21:48:42', '2024-09-23 21:48:42'),
(660, 70, 1, NULL, 'Stockiest Bonus', 'stockiest', 49.00, 'repurchase', NULL, NULL, '2024-09-23 21:48:43', '2024-09-23 21:48:43'),
(661, 70, 0, NULL, 'House Rent', 'admin', 35.00, 'repurchase', NULL, NULL, '2024-09-23 21:48:43', '2024-09-23 21:48:43'),
(662, 70, 0, NULL, 'Currier Cost', 'admin', 14.00, 'repurchase', NULL, NULL, '2024-09-23 21:48:43', '2024-09-23 21:48:43'),
(663, 70, 121, NULL, 'Stockiest Refer Bonus', 'user', 14.00, 'repurchase', NULL, NULL, '2024-09-23 21:48:43', '2024-09-23 21:48:43'),
(664, 70, 1, NULL, 'Depo Bonus', 'depo', 28.00, 'repurchase', NULL, NULL, '2024-09-23 21:48:43', '2024-09-23 21:48:43'),
(665, 70, 0, NULL, 'Marketing Cost', 'admin', 35.00, 'repurchase', NULL, NULL, '2024-09-23 21:48:43', '2024-09-23 21:48:43'),
(666, 70, 0, NULL, 'Company Fund', 'admin', 49.00, 'repurchase', NULL, NULL, '2024-09-23 21:48:43', '2024-09-23 21:48:43'),
(667, 71, 150, NULL, 'Purchase Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(668, 71, 147, NULL, 'Creating Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(669, 71, 147, 1, 'Refer Bonus', 'user', 2.50, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(670, 71, 141, 2, 'Refer Bonus', 'user', 7.50, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(671, 71, 139, 3, 'Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(672, 71, 138, 4, 'Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(673, 71, 136, 5, 'Refer Bonus', 'user', 2.50, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(674, 71, 133, 6, 'Refer Bonus', 'user', 1.25, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(675, 71, 121, 7, 'Refer Bonus', 'user', 1.25, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(676, 71, 150, NULL, 'Rank Reward Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(677, 71, 150, NULL, 'After Death Allowance', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(678, 71, 150, NULL, 'Company Profit Share', 'user', 12.50, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(679, 71, 1, NULL, 'Stockiest Bonus', 'stockiest', 17.50, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(680, 71, 121, NULL, 'Stockiest Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(681, 71, 1, NULL, 'Depo Bonus', 'depo', 10.00, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(682, 71, 150, NULL, 'Company Fund', 'admin', 17.50, 'active', NULL, NULL, '2024-09-23 22:25:18', '2024-09-23 22:25:18'),
(683, 72, 165, NULL, 'Purchase Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(684, 72, 159, NULL, 'Creating Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(685, 72, 159, 1, 'Refer Bonus', 'user', 2.50, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(686, 72, 158, 2, 'Refer Bonus', 'user', 7.50, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(687, 72, 143, 3, 'Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(688, 72, 142, 4, 'Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(689, 72, 140, 5, 'Refer Bonus', 'user', 2.50, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(690, 72, 139, 6, 'Refer Bonus', 'user', 1.25, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(691, 72, 138, 7, 'Refer Bonus', 'user', 1.25, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(692, 72, 165, NULL, 'Rank Reward Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(693, 72, 165, NULL, 'After Death Allowance', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(694, 72, 165, NULL, 'Company Profit Share', 'user', 12.50, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(695, 72, 1, NULL, 'Stockiest Bonus', 'stockiest', 17.50, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(696, 72, 121, NULL, 'Stockiest Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(697, 72, 1, NULL, 'Depo Bonus', 'depo', 10.00, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(698, 72, 165, NULL, 'Company Fund', 'admin', 17.50, 'active', NULL, NULL, '2024-09-23 22:28:27', '2024-09-23 22:28:27'),
(699, 73, 154, NULL, 'Purchase Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(700, 73, 150, NULL, 'Creating Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(701, 73, 150, 1, 'Refer Bonus', 'user', 4.75, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(702, 73, 147, 2, 'Refer Bonus', 'user', 14.25, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(703, 73, 141, 3, 'Refer Bonus', 'user', 9.50, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(704, 73, 139, 4, 'Refer Bonus', 'user', 9.50, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(705, 73, 138, 5, 'Refer Bonus', 'user', 4.75, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(706, 73, 136, 6, 'Refer Bonus', 'user', 2.38, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(707, 73, 133, 7, 'Refer Bonus', 'user', 2.38, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(708, 73, 154, NULL, 'Rank Reward Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(709, 73, 154, NULL, 'After Death Allowance', 'user', 9.50, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(710, 73, 154, NULL, 'Company Profit Share', 'user', 23.75, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(711, 73, 1, NULL, 'Stockiest Bonus', 'stockiest', 33.25, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(712, 73, 121, NULL, 'Stockiest Refer Bonus', 'user', 9.50, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(713, 73, 1, NULL, 'Depo Bonus', 'depo', 19.00, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(714, 73, 154, NULL, 'Company Fund', 'admin', 33.25, 'active', NULL, NULL, '2024-09-23 22:29:15', '2024-09-23 22:29:15'),
(715, 74, 255, NULL, 'Purchase Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(716, 74, 254, NULL, 'Creating Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(717, 74, 254, 1, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(718, 74, 251, 2, 'Refer Bonus', 'user', 5.25, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(719, 74, 175, 3, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(720, 74, 153, 4, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(721, 74, 149, 5, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(722, 74, 147, 6, 'Refer Bonus', 'user', 0.88, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(723, 74, 141, 7, 'Refer Bonus', 'user', 0.88, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(724, 74, 255, NULL, 'Rank Reward Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(725, 74, 255, NULL, 'After Death Allowance', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(726, 74, 255, NULL, 'Company Profit Share', 'user', 8.75, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(727, 74, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(728, 74, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(729, 74, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(730, 74, 255, NULL, 'Company Fund', 'admin', 12.25, 'active', NULL, NULL, '2024-09-23 22:30:24', '2024-09-23 22:30:24'),
(731, 75, 135, NULL, 'Purchase Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(732, 75, 132, NULL, 'Creating Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(733, 75, 132, 1, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(734, 75, 121, 2, 'Refer Bonus', 'user', 5.25, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(735, 75, 135, NULL, 'Rank Reward Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(736, 75, 135, NULL, 'After Death Allowance', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(737, 75, 135, NULL, 'Company Profit Share', 'user', 8.75, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(738, 75, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(739, 75, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(740, 75, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(741, 75, 135, NULL, 'Company Fund', 'admin', 12.25, 'active', NULL, NULL, '2024-09-23 22:31:41', '2024-09-23 22:31:41'),
(742, 76, 137, NULL, 'Purchase Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(743, 76, 133, NULL, 'Creating Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(744, 76, 133, 1, 'Refer Bonus', 'user', 2.25, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(745, 76, 121, 2, 'Refer Bonus', 'user', 6.75, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(746, 76, 137, NULL, 'Rank Reward Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(747, 76, 137, NULL, 'After Death Allowance', 'user', 4.50, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(748, 76, 137, NULL, 'Company Profit Share', 'user', 11.25, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(749, 76, 1, NULL, 'Stockiest Bonus', 'stockiest', 15.75, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(750, 76, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.50, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(751, 76, 1, NULL, 'Depo Bonus', 'depo', 9.00, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(752, 76, 137, NULL, 'Company Fund', 'admin', 15.75, 'active', NULL, NULL, '2024-09-23 22:34:39', '2024-09-23 22:34:39'),
(753, 77, 136, NULL, 'Purchase Bonus', 'user', 210.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(754, 77, 133, NULL, 'Creating Bonus', 'user', 140.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(755, 77, 133, 1, 'Refer Bonus', 'user', 7.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(756, 77, 121, 2, 'Refer Bonus', 'user', 28.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(757, 77, 1, NULL, 'Stockiest Bonus', 'stockiest', 49.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(758, 77, 0, NULL, 'House Rent', 'admin', 35.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(759, 77, 0, NULL, 'Currier Cost', 'admin', 14.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(760, 77, 121, NULL, 'Stockiest Refer Bonus', 'user', 14.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(761, 77, 1, NULL, 'Depo Bonus', 'depo', 28.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(762, 77, 0, NULL, 'Marketing Cost', 'admin', 35.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(763, 77, 0, NULL, 'Company Fund', 'admin', 49.00, 'repurchase', NULL, NULL, '2024-09-23 22:36:28', '2024-09-23 22:36:28'),
(764, 78, 134, NULL, 'Purchase Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(765, 78, 132, NULL, 'Creating Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(766, 78, 132, 1, 'Refer Bonus', 'user', 2.25, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(767, 78, 121, 2, 'Refer Bonus', 'user', 6.75, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(768, 78, 134, NULL, 'Rank Reward Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(769, 78, 134, NULL, 'After Death Allowance', 'user', 4.50, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(770, 78, 134, NULL, 'Company Profit Share', 'user', 11.25, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(771, 78, 1, NULL, 'Stockiest Bonus', 'stockiest', 15.75, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(772, 78, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.50, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(773, 78, 1, NULL, 'Depo Bonus', 'depo', 9.00, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(774, 78, 134, NULL, 'Company Fund', 'admin', 15.75, 'active', NULL, NULL, '2024-09-23 22:37:16', '2024-09-23 22:37:16'),
(775, 79, 135, NULL, 'Purchase Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(776, 79, 132, NULL, 'Creating Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(777, 79, 132, 1, 'Refer Bonus', 'user', 2.50, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(778, 79, 121, 2, 'Refer Bonus', 'user', 7.50, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(779, 79, 135, NULL, 'Rank Reward Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(780, 79, 135, NULL, 'After Death Allowance', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(781, 79, 135, NULL, 'Company Profit Share', 'user', 12.50, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(782, 79, 1, NULL, 'Stockiest Bonus', 'stockiest', 17.50, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(783, 79, 121, NULL, 'Stockiest Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(784, 79, 1, NULL, 'Depo Bonus', 'depo', 10.00, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(785, 79, 135, NULL, 'Company Fund', 'admin', 17.50, 'active', NULL, NULL, '2024-09-23 23:05:53', '2024-09-23 23:05:53'),
(786, 80, 135, NULL, 'Purchase Bonus', 'user', 142.50, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(787, 80, 132, NULL, 'Creating Bonus', 'user', 95.00, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(788, 80, 132, 1, 'Refer Bonus', 'user', 4.75, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(789, 80, 121, 2, 'Refer Bonus', 'user', 19.00, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(790, 80, 1, NULL, 'Stockiest Bonus', 'stockiest', 33.25, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(791, 80, 0, NULL, 'House Rent', 'admin', 23.75, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(792, 80, 0, NULL, 'Currier Cost', 'admin', 9.50, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(793, 80, 121, NULL, 'Stockiest Refer Bonus', 'user', 9.50, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(794, 80, 1, NULL, 'Depo Bonus', 'depo', 19.00, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(795, 80, 0, NULL, 'Marketing Cost', 'admin', 23.75, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(796, 80, 0, NULL, 'Company Fund', 'admin', 33.25, 'repurchase', NULL, NULL, '2024-09-23 23:06:40', '2024-09-23 23:06:40'),
(797, 81, 136, NULL, 'Purchase Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(798, 81, 133, NULL, 'Creating Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(799, 81, 133, 1, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(800, 81, 121, 2, 'Refer Bonus', 'user', 5.25, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(801, 81, 136, NULL, 'Rank Reward Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(802, 81, 136, NULL, 'After Death Allowance', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(803, 81, 136, NULL, 'Company Profit Share', 'user', 8.75, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(804, 81, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(805, 81, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(806, 81, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(807, 81, 136, NULL, 'Company Fund', 'admin', 12.25, 'active', NULL, NULL, '2024-09-23 23:08:14', '2024-09-23 23:08:14'),
(808, 82, 137, NULL, 'Purchase Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(809, 82, 133, NULL, 'Creating Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(810, 82, 133, 1, 'Refer Bonus', 'user', 2.25, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(811, 82, 121, 2, 'Refer Bonus', 'user', 6.75, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(812, 82, 137, NULL, 'Rank Reward Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(813, 82, 137, NULL, 'After Death Allowance', 'user', 4.50, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(814, 82, 137, NULL, 'Company Profit Share', 'user', 11.25, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(815, 82, 1, NULL, 'Stockiest Bonus', 'stockiest', 15.75, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(816, 82, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.50, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(817, 82, 1, NULL, 'Depo Bonus', 'depo', 9.00, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(818, 82, 137, NULL, 'Company Fund', 'admin', 15.75, 'active', NULL, NULL, '2024-09-23 23:08:44', '2024-09-23 23:08:44'),
(819, 83, 136, NULL, 'Purchase Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(820, 83, 133, NULL, 'Creating Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(821, 83, 133, 1, 'Refer Bonus', 'user', 2.50, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(822, 83, 121, 2, 'Refer Bonus', 'user', 7.50, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(823, 83, 136, NULL, 'Rank Reward Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(824, 83, 136, NULL, 'After Death Allowance', 'user', 5.00, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(825, 83, 136, NULL, 'Company Profit Share', 'user', 12.50, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(826, 83, 1, NULL, 'Stockiest Bonus', 'stockiest', 17.50, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(827, 83, 121, NULL, 'Stockiest Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(828, 83, 1, NULL, 'Depo Bonus', 'depo', 10.00, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(829, 83, 136, NULL, 'Company Fund', 'admin', 17.50, 'active', NULL, NULL, '2024-09-24 00:15:33', '2024-09-24 00:15:33'),
(830, 84, 137, NULL, 'Purchase Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(831, 84, 133, NULL, 'Creating Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(832, 84, 133, 1, 'Refer Bonus', 'user', 4.75, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(833, 84, 121, 2, 'Refer Bonus', 'user', 14.25, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(834, 84, 137, NULL, 'Rank Reward Bonus', 'user', 47.50, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(835, 84, 137, NULL, 'After Death Allowance', 'user', 9.50, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(836, 84, 137, NULL, 'Company Profit Share', 'user', 23.75, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(837, 84, 1, NULL, 'Stockiest Bonus', 'stockiest', 33.25, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(838, 84, 121, NULL, 'Stockiest Refer Bonus', 'user', 9.50, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(839, 84, 1, NULL, 'Depo Bonus', 'depo', 19.00, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(840, 84, 137, NULL, 'Company Fund', 'admin', 33.25, 'active', NULL, NULL, '2024-09-24 00:18:56', '2024-09-24 00:18:56'),
(841, 85, 135, NULL, 'Purchase Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(842, 85, 132, NULL, 'Creating Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(843, 85, 132, 1, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(844, 85, 121, 2, 'Refer Bonus', 'user', 5.25, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(845, 85, 135, NULL, 'Rank Reward Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(846, 85, 135, NULL, 'After Death Allowance', 'user', 3.50, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(847, 85, 135, NULL, 'Company Profit Share', 'user', 8.75, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(848, 85, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(849, 85, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(850, 85, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(851, 85, 135, NULL, 'Company Fund', 'admin', 12.25, 'active', NULL, NULL, '2024-09-24 00:19:26', '2024-09-24 00:19:26'),
(852, 86, 132, NULL, 'Purchase Bonus', 'user', 210.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(853, 86, 121, NULL, 'Creating Bonus', 'user', 140.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(854, 86, 121, 1, 'Refer Bonus', 'user', 7.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(855, 86, 1, NULL, 'Stockiest Bonus', 'stockiest', 49.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(856, 86, 0, NULL, 'House Rent', 'admin', 35.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(857, 86, 0, NULL, 'Currier Cost', 'admin', 14.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(858, 86, 121, NULL, 'Stockiest Refer Bonus', 'user', 14.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(859, 86, 1, NULL, 'Depo Bonus', 'depo', 28.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(860, 86, 0, NULL, 'Marketing Cost', 'admin', 35.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(861, 86, 0, NULL, 'Company Fund', 'admin', 49.00, 'repurchase', NULL, NULL, '2024-09-24 00:20:05', '2024-09-24 00:20:05'),
(862, 87, 133, NULL, 'Purchase Bonus', 'user', 67.50, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(863, 87, 121, NULL, 'Creating Bonus', 'user', 45.00, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(864, 87, 121, 1, 'Refer Bonus', 'user', 2.25, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(865, 87, 1, NULL, 'Stockiest Bonus', 'stockiest', 15.75, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(866, 87, 0, NULL, 'House Rent', 'admin', 11.25, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(867, 87, 0, NULL, 'Currier Cost', 'admin', 4.50, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(868, 87, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.50, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(869, 87, 1, NULL, 'Depo Bonus', 'depo', 9.00, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(870, 87, 0, NULL, 'Marketing Cost', 'admin', 11.25, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33'),
(871, 87, 0, NULL, 'Company Fund', 'admin', 15.75, 'repurchase', NULL, NULL, '2024-09-24 00:21:33', '2024-09-24 00:21:33');
INSERT INTO `redeem__beneficiaries` (`id`, `rp_redeemed_id`, `rp_beneficiary_id`, `ref_level`, `beneficiary_type`, `benifit_by`, `amount`, `activate_type`, `cb_distribute`, `gb_distribute`, `created_at`, `updated_at`) VALUES
(872, 88, 147, NULL, 'Purchase Bonus', 'user', 35.00, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(873, 88, 141, NULL, 'Creating Bonus', 'user', 35.00, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(874, 88, 141, 1, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(875, 88, 139, 2, 'Refer Bonus', 'user', 10.50, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(876, 88, 138, 3, 'Refer Bonus', 'user', 7.00, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(877, 88, 136, 4, 'Refer Bonus', 'user', 7.00, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(878, 88, 133, 5, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(879, 88, 121, 6, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(880, 88, 147, NULL, 'Rank Reward Bonus', 'user', 35.00, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(881, 88, 147, NULL, 'After Death Allowance', 'user', 7.00, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(882, 88, 147, NULL, 'Company Profit Share', 'user', 17.50, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(883, 88, 1, NULL, 'Stockiest Bonus', 'stockiest', 24.50, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(884, 88, 121, NULL, 'Stockiest Refer Bonus', 'user', 7.00, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(885, 88, 1, NULL, 'Depo Bonus', 'depo', 14.00, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(886, 88, 147, NULL, 'Company Fund', 'admin', 24.50, 'active', NULL, NULL, '2024-09-24 00:22:07', '2024-09-24 00:22:07'),
(887, 89, 144, NULL, 'Purchase Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(888, 89, 137, NULL, 'Creating Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(889, 89, 137, 1, 'Refer Bonus', 'user', 2.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(890, 89, 133, 2, 'Refer Bonus', 'user', 6.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(891, 89, 121, 3, 'Refer Bonus', 'user', 4.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(892, 89, 144, NULL, 'Rank Reward Bonus', 'user', 20.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(893, 89, 144, NULL, 'After Death Allowance', 'user', 4.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(894, 89, 144, NULL, 'Company Profit Share', 'user', 10.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(895, 89, 1, NULL, 'Stockiest Bonus', 'stockiest', 14.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(896, 89, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(897, 89, 1, NULL, 'Depo Bonus', 'depo', 8.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(898, 89, 144, NULL, 'Company Fund', 'admin', 14.00, 'active', NULL, NULL, '2024-09-24 00:22:51', '2024-09-24 00:22:51'),
(899, 90, 238, NULL, 'Purchase Bonus', 'user', 30.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(900, 90, 146, NULL, 'Creating Bonus', 'user', 30.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(901, 90, 146, 1, 'Refer Bonus', 'user', 3.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(902, 90, 145, 2, 'Refer Bonus', 'user', 9.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(903, 90, 144, 3, 'Refer Bonus', 'user', 6.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(904, 90, 137, 4, 'Refer Bonus', 'user', 6.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(905, 90, 133, 5, 'Refer Bonus', 'user', 3.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(906, 90, 121, 6, 'Refer Bonus', 'user', 1.50, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(907, 90, 238, NULL, 'Rank Reward Bonus', 'user', 30.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(908, 90, 238, NULL, 'After Death Allowance', 'user', 6.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(909, 90, 238, NULL, 'Company Profit Share', 'user', 15.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(910, 90, 1, NULL, 'Stockiest Bonus', 'stockiest', 21.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(911, 90, 121, NULL, 'Stockiest Refer Bonus', 'user', 6.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(912, 90, 1, NULL, 'Depo Bonus', 'depo', 12.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(913, 90, 238, NULL, 'Company Fund', 'admin', 21.00, 'active', NULL, NULL, '2024-09-24 00:25:49', '2024-09-24 00:25:49'),
(914, 91, 157, NULL, 'Purchase Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(915, 91, 145, NULL, 'Creating Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(916, 91, 145, 1, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(917, 91, 144, 2, 'Refer Bonus', 'user', 5.25, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(918, 91, 137, 3, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(919, 91, 133, 4, 'Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(920, 91, 121, 5, 'Refer Bonus', 'user', 1.75, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(921, 91, 157, NULL, 'Rank Reward Bonus', 'user', 17.50, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(922, 91, 157, NULL, 'After Death Allowance', 'user', 3.50, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(923, 91, 157, NULL, 'Company Profit Share', 'user', 8.75, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(924, 91, 1, NULL, 'Stockiest Bonus', 'stockiest', 12.25, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(925, 91, 121, NULL, 'Stockiest Refer Bonus', 'user', 3.50, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(926, 91, 1, NULL, 'Depo Bonus', 'depo', 7.00, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(927, 91, 157, NULL, 'Company Fund', 'admin', 12.25, 'active', NULL, NULL, '2024-09-24 00:26:24', '2024-09-24 00:26:24'),
(928, 215, 132, NULL, 'Purchase Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(929, 215, 121, NULL, 'Creating Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(930, 215, 121, 1, 'Refer Bonus', 'user', 2.50, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(931, 215, 132, NULL, 'Rank Reward Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(932, 215, 132, NULL, 'After Death Allowance', 'user', 5.00, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(933, 215, 132, NULL, 'Company Profit Share', 'user', 12.50, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(934, 215, 1, NULL, 'Stockiest Bonus', 'stockiest', 17.50, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(935, 215, 121, NULL, 'Stockiest Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(936, 215, 1, NULL, 'Depo Bonus', 'depo', 10.00, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(937, 215, 132, NULL, 'Company Fund', 'admin', 17.50, 'active', NULL, NULL, '2024-09-25 10:46:02', '2024-09-25 10:46:02'),
(938, 216, 136, NULL, 'Purchase Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(939, 216, 133, NULL, 'Creating Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(940, 216, 133, 1, 'Refer Bonus', 'user', 2.50, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(941, 216, 121, 2, 'Refer Bonus', 'user', 7.50, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(942, 216, 136, NULL, 'Rank Reward Bonus', 'user', 25.00, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(943, 216, 136, NULL, 'After Death Allowance', 'user', 5.00, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(944, 216, 136, NULL, 'Company Profit Share', 'user', 12.50, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(945, 216, 1, NULL, 'Stockiest Bonus', 'stockiest', 17.50, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(946, 216, 121, NULL, 'Stockiest Refer Bonus', 'user', 5.00, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(947, 216, 1, NULL, 'Depo Bonus', 'depo', 10.00, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(948, 216, 136, NULL, 'Company Fund', 'admin', 17.50, 'active', NULL, NULL, '2024-09-25 11:07:37', '2024-09-25 11:07:37'),
(949, 217, 137, NULL, 'Purchase Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(950, 217, 133, NULL, 'Creating Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(951, 217, 133, 1, 'Refer Bonus', 'user', 2.25, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(952, 217, 121, 2, 'Refer Bonus', 'user', 6.75, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(953, 217, 137, NULL, 'Rank Reward Bonus', 'user', 22.50, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(954, 217, 137, NULL, 'After Death Allowance', 'user', 4.50, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(955, 217, 137, NULL, 'Company Profit Share', 'user', 11.25, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(956, 217, 1, NULL, 'Stockiest Bonus', 'stockiest', 15.75, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(957, 217, 121, NULL, 'Stockiest Refer Bonus', 'user', 4.50, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(958, 217, 1, NULL, 'Depo Bonus', 'depo', 9.00, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(959, 217, 137, NULL, 'Company Fund', 'admin', 15.75, 'active', NULL, NULL, '2024-09-25 11:25:39', '2024-09-25 11:25:39'),
(960, 218, 309, NULL, 'Purchase Bonus', 'user', 70.00, 'active', NULL, NULL, '2024-09-25 11:42:59', '2024-09-25 11:42:59'),
(961, 218, 134, NULL, 'Creating Bonus', 'user', 70.00, 'active', NULL, NULL, '2024-09-25 11:42:59', '2024-09-25 11:42:59'),
(962, 218, 134, 1, 'Refer Bonus', 'user', 7.00, 'active', NULL, NULL, '2024-09-25 11:42:59', '2024-09-25 11:42:59'),
(963, 218, 132, 2, 'Refer Bonus', 'user', 21.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00'),
(964, 218, 121, 3, 'Refer Bonus', 'user', 14.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00'),
(965, 218, 309, NULL, 'Rank Reward Bonus', 'user', 70.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00'),
(966, 218, 309, NULL, 'After Death Allowance', 'user', 14.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00'),
(967, 218, 309, NULL, 'Company Profit Share', 'user', 35.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00'),
(968, 218, 1, NULL, 'Stockiest Bonus', 'stockiest', 49.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00'),
(969, 218, 121, NULL, 'Stockiest Refer Bonus', 'user', 14.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00'),
(970, 218, 1, NULL, 'Depo Bonus', 'depo', 28.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00'),
(971, 218, 309, NULL, 'Company Fund', 'admin', 49.00, 'active', NULL, NULL, '2024-09-25 11:43:00', '2024-09-25 11:43:00');

-- --------------------------------------------------------

--
-- Table structure for table `reference_counts`
--

CREATE TABLE `reference_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `ref_type` varchar(191) NOT NULL,
  `ref_count` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reference_counts`
--

INSERT INTO `reference_counts` (`id`, `ref_type`, `ref_count`, `business_id`, `created_at`, `updated_at`) VALUES
(1, 'contacts', 98, 1, '2023-02-23 22:00:02', '2023-12-17 03:58:15'),
(2, 'business_location', 3, 1, '2023-02-23 22:00:02', '2023-12-13 15:50:40'),
(3, 'sell_payment', 302, 1, '2023-04-18 17:31:22', '2024-08-01 16:40:46'),
(4, 'purchase', 30, 1, '2023-08-29 13:08:48', '2024-08-01 15:03:20'),
(5, 'purchase_payment', 30, 1, '2023-08-29 13:08:48', '2024-08-01 15:03:20'),
(6, 'draft', 4, 1, '2023-08-30 13:42:55', '2023-09-19 12:44:40'),
(7, 'expense', 38, 1, '2023-08-30 13:50:46', '2024-06-14 00:52:27'),
(8, 'expense_payment', 1, 1, '2023-09-01 16:58:01', '2023-09-01 16:58:01'),
(9, 'sell_return', 3, 1, '2023-09-11 12:07:59', '2023-09-23 15:08:00'),
(12, 'stock_transfer', 8, 1, '2024-01-04 03:00:29', '2024-02-03 03:23:30');

-- --------------------------------------------------------

--
-- Table structure for table `referrals`
--

CREATE TABLE `referrals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `referred_id` bigint(20) UNSIGNED NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `referrals`
--

INSERT INTO `referrals` (`id`, `user_id`, `referred_id`, `level`, `created_at`, `updated_at`) VALUES
(12, 123, 124, 2, '2024-08-19 08:19:14', '2024-08-19 08:19:14'),
(13, 123, 125, 2, '2024-08-19 08:25:57', '2024-08-19 08:25:57'),
(14, 123, 126, 2, '2024-08-19 08:27:08', '2024-08-19 08:27:08'),
(16, 124, 128, 3, '2024-08-19 08:28:46', '2024-08-19 08:28:46'),
(17, 124, 129, 3, '2024-08-19 08:30:12', '2024-08-19 08:30:12'),
(18, 125, 130, 3, '2024-08-19 08:30:59', '2024-08-19 08:30:59'),
(19, 128, 131, 4, '2024-08-20 11:28:12', '2024-08-20 11:28:12'),
(20, 121, 132, 1, '2024-08-23 07:15:15', '2024-08-23 07:15:15'),
(21, 121, 133, 1, '2024-08-23 07:16:44', '2024-08-23 07:16:44'),
(22, 132, 134, 2, '2024-08-23 07:21:22', '2024-08-23 07:21:22'),
(23, 132, 135, 2, '2024-08-23 07:22:26', '2024-08-23 07:22:26'),
(24, 133, 136, 2, '2024-08-23 07:25:35', '2024-08-23 07:25:35'),
(25, 133, 137, 2, '2024-08-23 07:30:06', '2024-08-23 07:30:06'),
(26, 136, 138, 3, '2024-08-23 07:31:17', '2024-08-23 07:31:17'),
(27, 138, 139, 4, '2024-08-23 07:32:31', '2024-08-23 07:32:31'),
(28, 139, 140, 5, '2024-08-23 07:33:49', '2024-08-23 07:33:49'),
(29, 139, 141, 5, '2024-08-23 07:34:55', '2024-08-23 07:34:55'),
(30, 140, 142, 6, '2024-08-23 07:36:19', '2024-08-23 07:36:19'),
(31, 142, 143, 7, '2024-08-23 07:37:36', '2024-08-23 07:37:36'),
(32, 137, 144, 3, '2024-08-23 07:38:30', '2024-08-23 07:38:30'),
(33, 144, 145, 4, '2024-08-23 07:39:27', '2024-08-23 07:39:27'),
(34, 145, 146, 5, '2024-08-23 07:41:29', '2024-08-23 07:41:29'),
(35, 141, 147, 6, '2024-08-23 07:42:43', '2024-08-23 07:42:43'),
(36, 141, 148, 6, '2024-08-23 07:43:43', '2024-08-23 07:43:43'),
(37, 147, 149, 7, '2024-08-23 07:44:46', '2024-08-23 07:44:46'),
(38, 147, 150, 7, '2024-08-23 07:55:18', '2024-08-23 07:55:18'),
(39, 148, 151, 7, '2024-08-23 08:13:21', '2024-08-23 08:13:21'),
(40, 148, 152, 7, '2024-08-23 08:22:17', '2024-08-23 08:22:17'),
(41, 149, 153, 8, '2024-08-23 08:25:42', '2024-08-23 08:25:42'),
(42, 150, 154, 8, '2024-08-23 08:26:59', '2024-08-23 08:26:59'),
(43, 152, 155, 8, '2024-08-23 08:29:23', '2024-08-23 08:29:23'),
(44, 145, 156, 5, '2024-08-23 08:34:50', '2024-08-23 08:34:50'),
(45, 145, 157, 5, '2024-08-23 08:35:54', '2024-08-23 08:35:54'),
(46, 143, 158, 8, '2024-08-23 08:36:51', '2024-08-23 08:36:51'),
(47, 158, 159, 9, '2024-08-23 09:08:50', '2024-08-23 09:08:50'),
(48, 143, 160, 8, '2024-08-23 09:12:19', '2024-08-23 09:12:19'),
(49, 160, 161, 9, '2024-08-23 09:13:31', '2024-08-23 09:13:31'),
(50, 160, 162, 9, '2024-08-23 09:14:24', '2024-08-23 09:14:24'),
(51, 162, 163, 10, '2024-08-23 09:15:13', '2024-08-23 09:15:13'),
(52, 159, 164, 10, '2024-08-23 09:16:04', '2024-08-23 09:16:04'),
(53, 159, 165, 10, '2024-08-23 09:16:56', '2024-08-23 09:16:56'),
(54, 165, 166, 11, '2024-08-23 09:18:01', '2024-08-23 09:18:01'),
(55, 166, 167, 12, '2024-08-23 09:19:16', '2024-08-23 09:19:16'),
(56, 167, 168, 13, '2024-08-23 09:20:14', '2024-08-23 09:20:14'),
(57, 168, 169, 14, '2024-08-23 09:21:16', '2024-08-23 09:21:16'),
(58, 169, 170, 15, '2024-08-23 09:22:12', '2024-08-23 09:22:12'),
(59, 170, 171, 16, '2024-08-23 09:24:24', '2024-08-23 09:24:24'),
(60, 157, 172, 6, '2024-08-23 09:26:20', '2024-08-23 09:26:20'),
(61, 157, 173, 6, '2024-08-23 10:20:52', '2024-08-23 10:20:52'),
(62, 153, 174, 9, '2024-08-23 10:21:45', '2024-08-23 10:21:45'),
(63, 153, 175, 9, '2024-08-23 10:22:42', '2024-08-23 10:22:42'),
(64, 157, 176, 6, '2024-08-23 10:23:41', '2024-08-23 10:23:41'),
(65, 145, 177, 5, '2024-08-23 10:24:38', '2024-08-23 10:24:38'),
(66, 145, 178, 5, '2024-08-23 10:25:37', '2024-08-23 10:25:37'),
(67, 157, 179, 6, '2024-08-23 10:26:49', '2024-08-23 10:26:49'),
(68, 157, 180, 6, '2024-08-23 10:27:44', '2024-08-23 10:27:44'),
(69, 155, 181, 9, '2024-08-23 10:28:53', '2024-08-23 10:28:53'),
(70, 155, 182, 9, '2024-08-23 10:29:53', '2024-08-23 10:29:53'),
(71, 181, 183, 10, '2024-08-23 10:30:51', '2024-08-23 10:30:51'),
(72, 183, 184, 11, '2024-08-23 10:31:44', '2024-08-23 10:31:44'),
(73, 183, 185, 11, '2024-08-23 10:32:38', '2024-08-23 10:32:38'),
(74, 185, 186, 12, '2024-08-23 10:33:28', '2024-08-23 10:33:28'),
(75, 186, 187, 13, '2024-08-23 10:40:37', '2024-08-23 10:40:37'),
(76, 183, 188, 11, '2024-08-23 10:41:33', '2024-08-23 10:41:33'),
(77, 183, 189, 11, '2024-08-23 10:42:30', '2024-08-23 10:42:30'),
(78, 185, 190, 12, '2024-08-23 10:43:20', '2024-08-23 10:43:20'),
(79, 162, 191, 10, '2024-08-23 10:51:11', '2024-08-23 10:51:11'),
(80, 162, 192, 10, '2024-08-23 10:52:11', '2024-08-23 10:52:11'),
(81, 192, 193, 11, '2024-08-23 10:53:27', '2024-08-23 10:53:27'),
(82, 162, 194, 10, '2024-08-23 10:54:15', '2024-08-23 10:54:15'),
(83, 162, 195, 10, '2024-08-23 10:55:06', '2024-08-23 10:55:06'),
(84, 162, 196, 10, '2024-08-23 10:55:58', '2024-08-23 10:55:58'),
(85, 163, 197, 11, '2024-08-23 10:57:19', '2024-08-23 10:57:19'),
(86, 160, 198, 9, '2024-08-23 10:58:15', '2024-08-23 10:58:15'),
(87, 160, 199, 9, '2024-08-23 10:59:17', '2024-08-23 10:59:17'),
(88, 160, 200, 9, '2024-08-23 11:00:09', '2024-08-23 11:00:09'),
(89, 160, 201, 9, '2024-08-23 11:01:16', '2024-08-23 11:01:16'),
(90, 160, 202, 9, '2024-08-23 11:02:11', '2024-08-23 11:02:11'),
(91, 160, 203, 9, '2024-08-23 11:03:06', '2024-08-23 11:03:06'),
(92, 160, 204, 9, '2024-08-23 11:03:54', '2024-08-23 11:03:54'),
(93, 160, 205, 9, '2024-08-23 11:23:44', '2024-08-23 11:23:44'),
(94, 160, 206, 9, '2024-08-23 11:25:01', '2024-08-23 11:25:01'),
(95, 160, 207, 9, '2024-08-23 11:26:08', '2024-08-23 11:26:08'),
(96, 160, 208, 9, '2024-08-23 11:27:09', '2024-08-23 11:27:09'),
(97, 160, 209, 9, '2024-08-23 11:28:42', '2024-08-23 11:28:42'),
(98, 160, 210, 9, '2024-08-23 11:29:55', '2024-08-23 11:29:55'),
(99, 207, 211, 10, '2024-08-23 11:30:47', '2024-08-23 11:30:47'),
(100, 205, 212, 10, '2024-08-23 11:31:47', '2024-08-23 11:31:47'),
(101, 212, 213, 11, '2024-08-23 11:32:35', '2024-08-23 11:32:35'),
(102, 161, 214, 10, '2024-08-23 11:33:27', '2024-08-23 11:33:27'),
(103, 161, 215, 10, '2024-08-23 11:40:47', '2024-08-23 11:40:47'),
(104, 161, 216, 10, '2024-08-23 11:42:01', '2024-08-23 11:42:01'),
(105, 161, 217, 10, '2024-08-23 11:45:48', '2024-08-23 11:45:48'),
(106, 160, 218, 9, '2024-08-23 11:48:37', '2024-08-23 11:48:37'),
(107, 160, 219, 9, '2024-08-23 11:49:34', '2024-08-23 11:49:34'),
(108, 160, 220, 9, '2024-08-23 11:50:39', '2024-08-23 11:50:39'),
(109, 160, 221, 9, '2024-08-23 11:52:08', '2024-08-23 11:52:08'),
(110, 159, 222, 10, '2024-08-23 11:53:33', '2024-08-23 11:53:33'),
(111, 159, 223, 10, '2024-08-23 11:56:05', '2024-08-23 11:56:05'),
(112, 159, 224, 10, '2024-08-24 00:04:12', '2024-08-24 00:04:12'),
(113, 159, 225, 10, '2024-08-24 00:05:08', '2024-08-24 00:05:08'),
(114, 159, 226, 10, '2024-08-24 00:06:05', '2024-08-24 00:06:05'),
(115, 159, 227, 10, '2024-08-24 00:07:01', '2024-08-24 00:07:01'),
(116, 159, 228, 10, '2024-08-24 00:08:04', '2024-08-24 00:08:04'),
(117, 159, 229, 10, '2024-08-24 00:09:22', '2024-08-24 00:09:22'),
(118, 159, 230, 10, '2024-08-24 00:10:16', '2024-08-24 00:10:16'),
(119, 159, 231, 10, '2024-08-24 00:11:01', '2024-08-24 00:11:01'),
(120, 159, 232, 10, '2024-08-24 00:12:09', '2024-08-24 00:12:09'),
(121, 159, 233, 10, '2024-08-24 00:12:55', '2024-08-24 00:12:55'),
(122, 159, 234, 10, '2024-08-24 00:13:57', '2024-08-24 00:13:57'),
(123, 174, 235, 10, '2024-08-24 00:15:17', '2024-08-24 00:15:17'),
(124, 235, 236, 11, '2024-08-24 00:16:58', '2024-08-24 00:16:58'),
(125, 235, 237, 11, '2024-08-24 00:17:47', '2024-08-24 00:17:47'),
(126, 146, 238, 6, '2024-08-24 00:18:39', '2024-08-24 00:18:39'),
(127, 236, 239, 12, '2024-08-24 00:20:02', '2024-08-24 00:20:02'),
(128, 239, 240, 13, '2024-08-24 00:21:04', '2024-08-24 00:21:04'),
(129, 239, 241, 13, '2024-08-24 00:25:56', '2024-08-24 00:25:56'),
(130, 239, 242, 13, '2024-08-24 00:27:03', '2024-08-24 00:27:03'),
(131, 239, 243, 13, '2024-08-24 00:28:06', '2024-08-24 00:28:06'),
(132, 239, 244, 13, '2024-08-24 00:29:12', '2024-08-24 00:29:12'),
(133, 239, 245, 13, '2024-08-24 00:30:45', '2024-08-24 00:30:45'),
(134, 239, 246, 13, '2024-08-24 00:31:32', '2024-08-24 00:31:32'),
(135, 239, 247, 13, '2024-08-24 00:32:20', '2024-08-24 00:32:20'),
(136, 239, 248, 13, '2024-08-24 00:33:05', '2024-08-24 00:33:05'),
(137, 239, 249, 13, '2024-08-24 00:33:53', '2024-08-24 00:33:53'),
(138, 146, 250, 6, '2024-08-24 02:30:11', '2024-08-24 02:30:11'),
(139, 175, 251, 10, '2024-08-24 05:09:42', '2024-08-24 05:09:42'),
(140, 251, 252, 11, '2024-08-24 05:11:17', '2024-08-24 05:11:17'),
(141, 251, 253, 11, '2024-08-24 05:12:19', '2024-08-24 05:12:19'),
(142, 251, 254, 11, '2024-08-24 05:15:43', '2024-08-24 05:15:43'),
(143, 254, 255, 12, '2024-08-24 05:18:51', '2024-08-24 05:18:51'),
(144, 254, 256, 12, '2024-08-24 05:20:20', '2024-08-24 05:20:20'),
(145, 251, 257, 11, '2024-08-24 05:24:49', '2024-08-24 05:24:49'),
(146, 257, 258, 12, '2024-08-24 05:30:18', '2024-08-24 05:30:18'),
(147, 257, 259, 12, '2024-08-24 05:31:46', '2024-08-24 05:31:46'),
(148, 254, 260, 12, '2024-08-24 05:38:11', '2024-08-24 05:38:11'),
(149, 154, 261, 9, '2024-08-24 06:08:15', '2024-08-24 06:08:15'),
(150, 154, 262, 9, '2024-08-24 06:09:37', '2024-08-24 06:09:37'),
(151, 154, 263, 9, '2024-08-24 06:11:06', '2024-08-24 06:11:06'),
(152, 154, 264, 9, '2024-08-24 06:12:13', '2024-08-24 06:12:13'),
(153, 154, 265, 9, '2024-08-24 06:13:13', '2024-08-24 06:13:13'),
(154, 154, 266, 9, '2024-08-24 06:15:17', '2024-08-24 06:15:17'),
(155, 159, 267, 10, '2024-08-24 07:50:10', '2024-08-24 07:50:10'),
(156, 159, 268, 10, '2024-08-24 07:52:18', '2024-08-24 07:52:18'),
(157, 159, 269, 10, '2024-08-24 07:54:54', '2024-08-24 07:54:54'),
(158, 159, 270, 10, '2024-08-24 08:02:54', '2024-08-24 08:02:54'),
(159, 159, 271, 10, '2024-08-24 08:05:09', '2024-08-24 08:05:09'),
(160, 159, 272, 10, '2024-08-24 08:08:42', '2024-08-24 08:08:42'),
(161, 121, 273, 1, '2024-08-24 08:10:07', '2024-08-24 08:10:07'),
(162, 159, 274, 10, '2024-08-24 08:11:17', '2024-08-24 08:11:17'),
(163, 160, 275, 9, '2024-08-24 08:14:53', '2024-08-24 08:14:53'),
(164, 142, 276, 7, '2024-08-24 08:54:16', '2024-08-24 08:54:16'),
(165, 276, 277, 8, '2024-08-24 08:57:19', '2024-08-24 08:57:19'),
(166, 276, 278, 8, '2024-08-24 08:58:30', '2024-08-24 08:58:30'),
(167, 263, 279, 10, '2024-08-25 06:32:05', '2024-08-25 06:32:05'),
(168, 265, 280, 10, '2024-08-25 06:34:54', '2024-08-25 06:34:54'),
(169, 280, 281, 11, '2024-08-25 06:37:50', '2024-08-25 06:37:50'),
(170, 281, 282, 12, '2024-08-25 06:39:45', '2024-08-25 06:39:45'),
(171, 266, 283, 10, '2024-08-25 06:44:56', '2024-08-25 06:44:56'),
(172, 239, 284, 13, '2024-08-26 02:29:14', '2024-08-26 02:29:14'),
(173, 239, 285, 13, '2024-08-26 02:31:27', '2024-08-26 02:31:27'),
(174, 239, 286, 13, '2024-08-26 02:33:53', '2024-08-26 02:33:53'),
(175, 239, 287, 13, '2024-08-26 02:37:34', '2024-08-26 02:37:34'),
(176, 264, 288, 10, '2024-08-26 02:41:40', '2024-08-26 02:41:40'),
(177, 183, 289, 11, '2024-08-26 02:49:48', '2024-08-26 02:49:48'),
(178, 285, 290, 14, '2024-08-26 02:53:23', '2024-08-26 02:53:23'),
(179, 159, 291, 10, '2024-08-26 21:58:03', '2024-08-26 21:58:03'),
(180, 160, 292, 9, '2024-08-26 21:59:12', '2024-08-26 21:59:12'),
(181, 157, 293, 6, '2024-08-27 00:05:06', '2024-08-27 00:05:06'),
(182, 145, 294, 5, '2024-08-27 00:06:42', '2024-08-27 00:06:42'),
(183, 157, 295, 6, '2024-08-27 00:08:06', '2024-08-27 00:08:06'),
(184, 157, 296, 6, '2024-08-27 00:09:31', '2024-08-27 00:09:31'),
(185, 288, 297, 11, '2024-08-27 00:19:17', '2024-08-27 00:19:17'),
(186, 288, 298, 11, '2024-08-27 00:20:41', '2024-08-27 00:20:41'),
(187, 133, 299, 2, '2024-09-09 00:59:58', '2024-09-09 00:59:58'),
(188, 135, 300, 3, '2024-09-09 01:02:59', '2024-09-09 01:02:59'),
(189, 134, 302, 3, '2024-09-18 00:15:25', '2024-09-18 00:15:25'),
(190, 134, 303, 3, '2024-09-18 00:18:10', '2024-09-18 00:18:10'),
(191, 134, 304, 3, '2024-09-18 00:33:32', '2024-09-18 00:33:32'),
(192, 134, 305, 3, '2024-09-18 00:36:33', '2024-09-18 00:36:33'),
(193, 134, 306, 3, '2024-09-18 00:37:38', '2024-09-18 00:37:38'),
(194, 134, 307, 3, '2024-09-18 00:45:15', '2024-09-18 00:45:15'),
(195, 134, 308, 3, '2024-09-18 01:01:14', '2024-09-18 01:01:14'),
(196, 134, 309, 3, '2024-09-18 01:02:55', '2024-09-18 01:02:55');

-- --------------------------------------------------------

--
-- Table structure for table `refer_percent`
--

CREATE TABLE `refer_percent` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `percent` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refer_percent`
--

INSERT INTO `refer_percent` (`id`, `name`, `percent`) VALUES
(1, '1st person', '3'),
(2, '2nd person', '2'),
(3, '3rd person', '2'),
(4, '4th person', '1'),
(5, '5th person', '1'),
(6, '6th person', '0.5'),
(7, '7th person', '0.5');

-- --------------------------------------------------------

--
-- Table structure for table `res_product_modifier_sets`
--

CREATE TABLE `res_product_modifier_sets` (
  `modifier_set_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL COMMENT 'Table use to store the modifier sets applicable for a product'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `res_tables`
--

CREATE TABLE `res_tables` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `re_purchase`
--

CREATE TABLE `re_purchase` (
  `id` bigint(20) NOT NULL,
  `purchase_bonus` varchar(25) NOT NULL,
  `creating_bonus` varchar(25) NOT NULL,
  `re_creating_bonus` varchar(25) NOT NULL,
  `championship_bonus` varchar(25) NOT NULL,
  `guardianship_bonus` varchar(25) NOT NULL,
  `stokist_bonus` varchar(25) NOT NULL,
  `stokist_refer_bonus` varchar(25) NOT NULL,
  `depo_bonus` varchar(25) NOT NULL,
  `marketting_cost` varchar(25) NOT NULL,
  `house_rent` varchar(25) NOT NULL,
  `couriar_cost` varchar(25) NOT NULL,
  `company_fund` varchar(25) NOT NULL,
  `_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `re_purchase`
--

INSERT INTO `re_purchase` (`id`, `purchase_bonus`, `creating_bonus`, `re_creating_bonus`, `championship_bonus`, `guardianship_bonus`, `stokist_bonus`, `stokist_refer_bonus`, `depo_bonus`, `marketting_cost`, `house_rent`, `couriar_cost`, `company_fund`, `_token`) VALUES
(1, '25%', '10%', '10%', '5%', '3%', '7%', '2%', '4%', '12%', '10%', '5%', '7%', 'KR3Rh86E6nZozn6XxhfkoZkovbrlHuYT0ceMStMZ');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_service_staff` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `business_id`, `is_default`, `is_service_staff`, `created_at`, `updated_at`) VALUES
(1, 'Admin#1', 'web', 1, 1, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(2, 'Cashier#1', 'web', 1, 0, 0, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(4, 'DEPO#1', 'web', 1, 0, 0, '2023-12-12 18:37:55', '2023-12-12 18:37:55'),
(5, 'Stockist#1', 'web', 1, 0, 0, '2023-12-12 18:40:15', '2023-12-12 18:40:15');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 5),
(2, 2),
(2, 5),
(3, 4),
(3, 5),
(6, 5),
(7, 4),
(7, 5),
(8, 2),
(8, 5),
(9, 5),
(10, 5),
(16, 2),
(16, 5),
(17, 2),
(17, 4),
(17, 5),
(18, 2),
(18, 5),
(19, 2),
(19, 5),
(20, 2),
(20, 5),
(22, 4),
(22, 5),
(25, 2),
(25, 5),
(26, 2),
(26, 5),
(27, 2),
(27, 5),
(28, 4),
(28, 5),
(33, 5),
(34, 5),
(35, 5),
(36, 2),
(36, 5),
(37, 2),
(37, 5),
(40, 2),
(40, 4),
(40, 5),
(41, 4),
(41, 5),
(42, 4),
(42, 5),
(43, 4),
(43, 5),
(44, 2),
(45, 4),
(45, 5),
(46, 4),
(46, 5),
(47, 4),
(47, 5),
(48, 2),
(48, 5),
(49, 2),
(49, 5),
(50, 5),
(51, 5),
(52, 2),
(52, 5),
(53, 2),
(53, 5),
(54, 2),
(54, 5),
(55, 5),
(56, 2),
(56, 5),
(57, 2),
(57, 5),
(58, 2),
(58, 5),
(59, 2),
(59, 5),
(63, 2),
(63, 5),
(64, 5),
(65, 5),
(66, 5),
(67, 2),
(67, 5),
(68, 2),
(68, 5),
(69, 5),
(70, 5),
(71, 5),
(72, 5),
(73, 5),
(74, 5),
(75, 2),
(75, 5),
(76, 5),
(77, 5),
(78, 5),
(81, 2),
(81, 5),
(83, 2),
(83, 5),
(84, 2),
(84, 5),
(85, 2),
(85, 5),
(86, 2),
(86, 5),
(87, 5),
(88, 5),
(89, 2),
(89, 5),
(90, 5),
(91, 5),
(92, 5),
(93, 2),
(93, 5),
(94, 2),
(94, 5),
(95, 5),
(96, 2),
(96, 5),
(97, 2),
(97, 5),
(101, 2),
(101, 5),
(102, 2),
(102, 5),
(103, 2),
(104, 2),
(105, 4),
(105, 5),
(106, 4),
(106, 5),
(107, 4),
(107, 5),
(113, 5);

-- --------------------------------------------------------

--
-- Table structure for table `rp_redeemed_c_users`
--

CREATE TABLE `rp_redeemed_c_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `c_user_id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `price_value` float(8,2) DEFAULT NULL,
  `point` float(8,2) DEFAULT NULL,
  `type` enum('activate','repurchase') NOT NULL DEFAULT 'repurchase',
  `created_by` int(191) DEFAULT NULL,
  `created_by_type` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rp_redeemed_c_users`
--

INSERT INTO `rp_redeemed_c_users` (`id`, `c_user_id`, `transaction_id`, `price_value`, `point`, `type`, `created_by`, `created_by_type`, `created_at`, `updated_at`) VALUES
(215, 132, 76, 3750.00, 250.00, 'activate', NULL, NULL, '2024-09-30 10:46:02', '2024-09-25 10:46:02'),
(216, 136, 77, 3750.00, 250.00, 'activate', NULL, NULL, '2024-09-30 11:07:37', '2024-09-25 11:07:37'),
(217, 137, 81, 3375.00, 225.00, 'activate', NULL, NULL, '2024-09-30 11:25:39', '2024-09-25 11:25:39'),
(218, 309, 82, 10500.00, 700.00, 'activate', NULL, NULL, '2024-09-30 11:42:59', '2024-09-25 11:42:59');

-- --------------------------------------------------------

--
-- Table structure for table `selling_price_groups`
--

CREATE TABLE `selling_price_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sell_line_warranties`
--

CREATE TABLE `sell_line_warranties` (
  `sell_line_id` int(11) NOT NULL,
  `warranty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('IFXFmE0pRU1mfNdJxqHxfoX8yfZ0dh4AqVSpqZ5d', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibThVVVpMbjhycEJUV1RSRkFUQzh4NWlWeFNMZ25NdExFemlPTWNhZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi9jYXB0YWluc2hpcF9ib251c19saXN0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1727764205),
('sa8bfdguY9E03yzs5iaKeCf6vMmmZFjBs2qQppJ6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYWVrY3VleEZrQktQOHlGM21KbWFLU2Q0cHhzU0tHWnRLTmZxc1M4TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC91c2VyL2Rhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTc6ImxvZ2luX2N1c3RvbVVzZXJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxMjE7fQ==', 1727767966);

-- --------------------------------------------------------

--
-- Table structure for table `stockiests`
--

CREATE TABLE `stockiests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `stockiest_name` varchar(255) NOT NULL,
  `image` mediumtext DEFAULT NULL,
  `blood_group` varchar(191) DEFAULT NULL,
  `stockiest_contact_person_name` varchar(255) NOT NULL,
  `contact_number` varchar(255) NOT NULL,
  `stockiest_email_id` varchar(255) NOT NULL,
  `stockiest_address` varchar(255) NOT NULL,
  `depo_id` varchar(255) NOT NULL,
  `stockiest_arya` varchar(255) NOT NULL,
  `stockiest_user_id` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `stockiest_ref` varchar(191) DEFAULT NULL,
  `stockiest_ref_id` int(255) DEFAULT NULL,
  `stockiest_ref_id_type` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stockiests`
--

INSERT INTO `stockiests` (`id`, `stockiest_name`, `image`, `blood_group`, `stockiest_contact_person_name`, `contact_number`, `stockiest_email_id`, `stockiest_address`, `depo_id`, `stockiest_arya`, `stockiest_user_id`, `password`, `stockiest_ref`, `stockiest_ref_id`, `stockiest_ref_id_type`, `created_at`, `updated_at`) VALUES
(1, 'ITR HELTH CARE LTD 23', 'upload/profile/1726069606.jpg', 'O+', 'MD RAJU AHMED', '01766855006', 'itrhelthcareltd@gmail.com', 'Life Care Hospital Vbon, House-13, 9 Floor-A, Sultana Rajiya Road, Auchpara, Kolleggate, Tongi, Gazipur', '1', 'Tongi 54 No Worad', 'itrsp-0001', '$2y$12$h51nyZUAd828CP7gi80gReDlwy5PwtIS1LQbKYwq5hZI1xb1ViKMa', NULL, 121, 'user', NULL, '2024-09-11 09:55:00'),
(2, 'Maile Potter', NULL, NULL, 'Ayanna Carey', '283', 'zetuq@mailinator.com', 'Quos ut beatae tempo', '2', 'Voluptas laborum nos', 'itrsp-0002', '$2y$12$PTdFHyNLY51DvYSGQoYVgu1eEhYeJ8oC2OGHxkHE9wJm37.ws67Li', NULL, 135, 'user', NULL, '2024-09-03 08:37:04'),
(4, 'Amaya Mccarty', NULL, NULL, 'Kimberly Anthony', '903', 'qybaso@mailinator.com', 'Eius ipsum et paria', '2', 'Non commodi elit te', 'itrsp-0003', '$2y$12$M23M6yJonDr0jfnRzpRU3O0iLAx2dHL6esjuUi7gmwO1RlJYw/jyC', NULL, 121, 'user', NULL, '2024-05-06 02:47:31'),
(5, 'India Solis', NULL, NULL, 'Anjolie Stephens', '834', 'lujoku@mailinator.com', 'Rangpur', '7', 'Majar Road', 'itrsp-0004', '$2y$12$VK/gQdZ7e73XUZyTB7JCy.AOZOqLMAcTx/udjhkAwosJqDEWsLusG', 'ITRHCL-0007', 137, 'user', NULL, '2024-09-03 09:26:36');

-- --------------------------------------------------------

--
-- Table structure for table `stockiest_withdraw_balances`
--

CREATE TABLE `stockiest_withdraw_balances` (
  `id` int(11) NOT NULL,
  `stockiest_id` int(11) DEFAULT NULL,
  `amount` float(15,2) DEFAULT NULL,
  `withdraw_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stockiest_withdraw_balances`
--

INSERT INTO `stockiest_withdraw_balances` (`id`, `stockiest_id`, `amount`, `withdraw_id`, `created_at`, `updated_at`) VALUES
(1, 1, 200.00, 4, '2024-09-09 09:22:25', '2024-09-09 09:22:25');

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustments_temp`
--

CREATE TABLE `stock_adjustments_temp` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustment_lines`
--

CREATE TABLE `stock_adjustment_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL,
  `secondary_unit_quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Last purchase unit price',
  `removed_purchase_line` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system`
--

CREATE TABLE `system` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system`
--

INSERT INTO `system` (`id`, `key`, `value`) VALUES
(1, 'db_version', '4.8'),
(2, 'default_business_active_status', '1');

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

CREATE TABLE `tax_rates` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `amount` double(22,4) NOT NULL,
  `is_tax_group` tinyint(1) NOT NULL DEFAULT 0,
  `for_tax_group` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `total_bonus_points`
--

CREATE TABLE `total_bonus_points` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_bonus` float(15,2) NOT NULL DEFAULT 0.00,
  `creating_bonus` float(15,2) NOT NULL DEFAULT 0.00,
  `re_creating_bonus` float(15,2) NOT NULL DEFAULT 0.00,
  `refer_bonus` float(15,2) NOT NULL DEFAULT 0.00,
  `equal_bonus` float(15,2) NOT NULL DEFAULT 0.00,
  `rank_reward_bonus` float(15,2) NOT NULL DEFAULT 0.00,
  `captainship_bonus` float(15,2) NOT NULL DEFAULT 0.00,
  `guardianship_bonus` float(15,2) DEFAULT 0.00,
  `after_death_allowance` float(15,2) NOT NULL DEFAULT 0.00,
  `company_profit_share` float(15,2) NOT NULL DEFAULT 0.00,
  `company_fund` float(15,2) NOT NULL DEFAULT 0.00,
  `stockiest_refer_bonus` float(15,2) DEFAULT 0.00,
  `stockiest_bonus` float(15,2) DEFAULT 0.00,
  `stockiest_withdraw` float(15,2) DEFAULT 0.00,
  `house_rent` float(15,2) NOT NULL DEFAULT 0.00,
  `currier_cost` float(15,2) NOT NULL DEFAULT 0.00,
  `benefit_by` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `total_bonus_points`
--

INSERT INTO `total_bonus_points` (`id`, `user_id`, `purchase_bonus`, `creating_bonus`, `re_creating_bonus`, `refer_bonus`, `equal_bonus`, `rank_reward_bonus`, `captainship_bonus`, `guardianship_bonus`, `after_death_allowance`, `company_profit_share`, `company_fund`, `stockiest_refer_bonus`, `stockiest_bonus`, `stockiest_withdraw`, `house_rent`, `currier_cost`, `benefit_by`, `created_at`, `updated_at`) VALUES
(18, 121, 405.00, 245.00, 201.25, 0.00, 3.75, 0.00, 2.25, 0.00, 3.50, 8.75, 0.00, NULL, NULL, NULL, 0.00, 0.00, 'user', NULL, '2024-10-01 01:18:37'),
(19, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, NULL, 187.50, 75.00, 'admin', NULL, NULL),
(20, 132, 310.00, 177.50, 82.75, 0.00, 0.00, 47.50, 0.40, 0.27, 9.50, 23.75, 0.00, NULL, NULL, NULL, 0.00, 0.00, 'user', NULL, '2024-09-10 01:59:12'),
(21, 133, 95.00, 350.00, 58.99, 0.00, 11.25, 27.50, 0.90, 0.27, 5.50, 13.75, 0.00, NULL, NULL, NULL, 0.00, 0.00, 'user', NULL, '2024-09-10 01:59:12'),
(22, 136, 305.00, 0.00, 14.26, 0.00, 0.00, 95.00, 0.20, 0.18, 19.00, 47.50, 0.00, NULL, NULL, NULL, 0.00, 0.00, 'user', NULL, '2024-09-10 01:59:12'),
(25, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 810.25, 0.00, 8.75, 3.50, 'stockiest', NULL, '2024-09-09 11:33:30'),
(28, 309, 282.50, 0.00, 0.00, 0.00, 0.00, 192.50, 0.00, 0.00, 38.50, 96.25, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(29, 134, 22.50, 252.50, 22.25, 0.00, 0.00, 22.50, 0.00, 0.00, 4.50, 11.25, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(30, 160, 47.50, 0.00, 0.00, 0.00, 0.00, 47.50, 0.00, 0.00, 9.50, 23.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(31, 143, 0.00, 47.50, 9.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(32, 142, 0.00, 0.00, 19.25, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(33, 140, 0.00, 0.00, 12.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(34, 139, 0.00, 0.00, 35.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(35, 138, 0.00, 0.00, 22.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(36, 145, 17.50, 17.50, 10.75, 0.00, 0.00, 17.50, 0.00, 0.00, 3.50, 8.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(37, 144, 20.00, 17.50, 13.00, 0.00, 0.00, 20.00, 0.00, 0.00, 4.00, 10.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(38, 137, 115.00, 20.00, 16.75, 0.00, 0.00, 115.00, 0.00, 0.00, 23.00, 57.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(39, 150, 25.00, 47.50, 4.75, 0.00, 0.00, 25.00, 0.00, 0.00, 5.00, 12.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(40, 147, 35.00, 25.00, 17.62, 0.00, 0.00, 35.00, 0.00, 0.00, 7.00, 17.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(41, 141, 0.00, 35.00, 21.38, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(42, 165, 25.00, 0.00, 0.00, 0.00, 0.00, 25.00, 0.00, 0.00, 5.00, 12.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(43, 159, 0.00, 25.00, 2.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(44, 158, 0.00, 0.00, 7.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(45, 154, 47.50, 0.00, 0.00, 0.00, 0.00, 47.50, 0.00, 0.00, 9.50, 23.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(46, 255, 17.50, 0.00, 0.00, 0.00, 0.00, 17.50, 0.00, 0.00, 3.50, 8.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(47, 254, 0.00, 17.50, 1.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(48, 251, 0.00, 0.00, 5.25, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(49, 175, 0.00, 0.00, 3.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(50, 153, 0.00, 0.00, 3.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(51, 149, 0.00, 0.00, 1.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(52, 135, 202.50, 0.00, 0.00, 0.00, 0.00, 60.00, 0.00, 0.00, 12.00, 30.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(53, 238, 30.00, 0.00, 0.00, 0.00, 0.00, 30.00, 0.00, 0.00, 6.00, 15.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(54, 146, 0.00, 30.00, 3.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL),
(55, 157, 17.50, 0.00, 0.00, 0.00, 0.00, 17.50, 0.00, 0.00, 3.50, 8.75, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'user', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED DEFAULT NULL,
  `res_table_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_waiter_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_order_status` enum('received','cooked','served') DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `sub_type` varchar(20) DEFAULT NULL,
  `status` varchar(191) NOT NULL,
  `sub_status` varchar(191) DEFAULT NULL,
  `is_quotation` tinyint(1) NOT NULL DEFAULT 0,
  `payment_status` enum('paid','due','partial') DEFAULT NULL,
  `adjustment_type` enum('normal','abnormal') DEFAULT NULL,
  `contact_id` int(10) UNSIGNED DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL COMMENT 'used to add customer group while selling',
  `invoice_no` varchar(191) DEFAULT NULL,
  `ref_no` varchar(191) DEFAULT NULL,
  `source` varchar(191) DEFAULT NULL,
  `subscription_no` varchar(191) DEFAULT NULL,
  `subscription_repeat_on` varchar(191) DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `total_before_tax` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total before the purchase/invoice tax, this includeds the indivisual product tax',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `tax_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `discount_type` enum('fixed','percentage') DEFAULT NULL,
  `discount_amount` decimal(22,4) DEFAULT 0.0000,
  `rp_redeemed` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `rp_redeemed_amount` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'rp is the short form of reward points',
  `shipping_details` varchar(191) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `shipping_status` varchar(191) DEFAULT NULL,
  `delivered_to` varchar(191) DEFAULT NULL,
  `shipping_charges` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `shipping_custom_field_1` varchar(191) DEFAULT NULL,
  `shipping_custom_field_2` varchar(191) DEFAULT NULL,
  `shipping_custom_field_3` varchar(191) DEFAULT NULL,
  `shipping_custom_field_4` varchar(191) DEFAULT NULL,
  `shipping_custom_field_5` varchar(191) DEFAULT NULL,
  `additional_notes` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `is_export` tinyint(1) NOT NULL DEFAULT 0,
  `export_custom_fields_info` longtext DEFAULT NULL,
  `round_off_amount` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Difference of rounded total and actual total',
  `additional_expense_key_1` varchar(191) DEFAULT NULL,
  `additional_expense_value_1` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `additional_expense_key_2` varchar(191) DEFAULT NULL,
  `additional_expense_value_2` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `additional_expense_key_3` varchar(191) DEFAULT NULL,
  `additional_expense_value_3` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `additional_expense_key_4` varchar(191) DEFAULT NULL,
  `additional_expense_value_4` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `final_total` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `expense_category_id` int(10) UNSIGNED DEFAULT NULL,
  `expense_sub_category_id` int(11) DEFAULT NULL,
  `expense_for` int(10) UNSIGNED DEFAULT NULL,
  `commission_agent` int(11) DEFAULT NULL,
  `document` varchar(191) DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT 0,
  `is_suspend` tinyint(1) NOT NULL DEFAULT 0,
  `exchange_rate` decimal(20,3) NOT NULL DEFAULT 1.000,
  `total_amount_recovered` decimal(22,4) DEFAULT NULL COMMENT 'Used for stock adjustment.',
  `transfer_parent_id` int(11) DEFAULT NULL,
  `return_parent_id` int(11) DEFAULT NULL,
  `opening_stock_product_id` int(11) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `purchase_requisition_ids` text DEFAULT NULL,
  `prefer_payment_method` varchar(191) DEFAULT NULL,
  `prefer_payment_account` int(11) DEFAULT NULL,
  `sales_order_ids` text DEFAULT NULL,
  `purchase_order_ids` text DEFAULT NULL,
  `custom_field_1` varchar(191) DEFAULT NULL,
  `custom_field_2` varchar(191) DEFAULT NULL,
  `custom_field_3` varchar(191) DEFAULT NULL,
  `custom_field_4` varchar(191) DEFAULT NULL,
  `import_batch` int(11) DEFAULT NULL,
  `import_time` datetime DEFAULT NULL,
  `types_of_service_id` int(11) DEFAULT NULL,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') DEFAULT NULL,
  `service_custom_field_1` text DEFAULT NULL,
  `service_custom_field_2` text DEFAULT NULL,
  `service_custom_field_3` text DEFAULT NULL,
  `service_custom_field_4` text DEFAULT NULL,
  `service_custom_field_5` text DEFAULT NULL,
  `service_custom_field_6` text DEFAULT NULL,
  `is_created_from_api` tinyint(1) NOT NULL DEFAULT 0,
  `rp_earned` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `order_addresses` text DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `recur_interval` double(22,4) DEFAULT NULL,
  `recur_interval_type` enum('days','months','years') DEFAULT NULL,
  `recur_repetitions` int(11) DEFAULT NULL,
  `recur_stopped_on` datetime DEFAULT NULL,
  `recur_parent_id` int(11) DEFAULT NULL,
  `invoice_token` varchar(191) DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') DEFAULT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `transaction_type` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `business_id`, `location_id`, `res_table_id`, `res_waiter_id`, `res_order_status`, `type`, `sub_type`, `status`, `sub_status`, `is_quotation`, `payment_status`, `adjustment_type`, `contact_id`, `customer_group_id`, `invoice_no`, `ref_no`, `source`, `subscription_no`, `subscription_repeat_on`, `transaction_date`, `total_before_tax`, `tax_id`, `tax_amount`, `discount_type`, `discount_amount`, `rp_redeemed`, `rp_redeemed_amount`, `shipping_details`, `shipping_address`, `delivery_date`, `shipping_status`, `delivered_to`, `shipping_charges`, `shipping_custom_field_1`, `shipping_custom_field_2`, `shipping_custom_field_3`, `shipping_custom_field_4`, `shipping_custom_field_5`, `additional_notes`, `staff_note`, `is_export`, `export_custom_fields_info`, `round_off_amount`, `additional_expense_key_1`, `additional_expense_value_1`, `additional_expense_key_2`, `additional_expense_value_2`, `additional_expense_key_3`, `additional_expense_value_3`, `additional_expense_key_4`, `additional_expense_value_4`, `final_total`, `expense_category_id`, `expense_sub_category_id`, `expense_for`, `commission_agent`, `document`, `is_direct_sale`, `is_suspend`, `exchange_rate`, `total_amount_recovered`, `transfer_parent_id`, `return_parent_id`, `opening_stock_product_id`, `created_by`, `purchase_requisition_ids`, `prefer_payment_method`, `prefer_payment_account`, `sales_order_ids`, `purchase_order_ids`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `import_batch`, `import_time`, `types_of_service_id`, `packing_charge`, `packing_charge_type`, `service_custom_field_1`, `service_custom_field_2`, `service_custom_field_3`, `service_custom_field_4`, `service_custom_field_5`, `service_custom_field_6`, `is_created_from_api`, `rp_earned`, `order_addresses`, `is_recurring`, `recur_interval`, `recur_interval_type`, `recur_repetitions`, `recur_stopped_on`, `recur_parent_id`, `invoice_token`, `pay_term_number`, `pay_term_type`, `selling_price_group_id`, `transaction_type`, `created_at`, `updated_at`) VALUES
(45, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 30, NULL, '0252', '', NULL, NULL, NULL, '2024-06-13 23:59:14', 2450.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2450.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-06-13 23:59:14', '2024-07-14 06:09:45'),
(61, 1, 1, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-01 13:05:00', 0.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 0.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 286, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-14 13:05:07', '2024-07-15 20:42:34'),
(74, 1, 1, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-01 14:15:00', 195.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 195.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 516, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-28 14:15:31', '2024-07-29 19:44:01'),
(75, 1, 1, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-01 14:15:00', 19500.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 19500.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 516, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-28 14:15:33', '2024-07-29 19:44:01'),
(76, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0275', '', NULL, NULL, NULL, '2024-07-28 14:16:30', 3750.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3750.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 250, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 1, '2024-07-28 14:16:30', '2024-09-25 10:46:02'),
(77, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0276', '', NULL, NULL, NULL, '2024-07-29 19:09:59', 3750.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3750.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 250, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 1, '2024-07-29 19:09:59', '2024-09-25 11:07:37'),
(78, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0277', '', NULL, NULL, NULL, '2024-07-29 19:16:21', 7125.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 7125.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 475, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-07-29 19:16:21', '2024-09-24 00:18:56'),
(79, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0278', '', NULL, NULL, NULL, '2024-07-29 19:16:52', 2625.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2625.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 175, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-07-29 19:16:52', '2024-09-23 22:30:24'),
(80, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0279', '', NULL, NULL, NULL, '2024-07-29 19:17:17', 2625.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2625.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 175, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-07-29 19:17:17', '2024-09-24 00:19:26'),
(81, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0280', '', NULL, NULL, NULL, '2024-07-29 19:17:47', 3375.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3375.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 225, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 1, '2024-07-29 19:17:47', '2024-09-25 11:25:39'),
(82, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0281', '', NULL, NULL, NULL, '2024-07-29 19:18:13', 10500.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 10500.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 700, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 1, '2024-07-29 19:18:13', '2024-09-25 11:42:59'),
(83, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0282', '', NULL, NULL, NULL, '2024-07-29 19:44:41', 3375.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3375.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 225, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-07-29 19:44:41', '2024-09-24 00:21:33'),
(84, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0283', '', NULL, NULL, NULL, '2024-07-29 19:45:41', 4125.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4125.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 275, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-07-29 19:45:41', '2024-08-30 02:49:45'),
(85, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0284', '', NULL, NULL, NULL, '2024-07-29 19:46:02', 4125.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4125.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 275, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-07-29 19:46:02', '2024-08-30 02:50:26'),
(86, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0285', '', NULL, NULL, NULL, '2024-07-29 19:46:02', 4125.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4125.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 275, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-07-29 19:46:02', '2024-09-06 04:22:43'),
(87, 1, 1, NULL, NULL, NULL, 'purchase', NULL, 'received', NULL, 0, 'paid', NULL, 19, NULL, NULL, '111', NULL, NULL, NULL, '2024-08-01 15:02:00', 9750000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 9750000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'months', NULL, 0, '2024-08-01 15:03:20', '2024-08-01 15:03:20'),
(88, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0285', '', NULL, NULL, NULL, '2024-08-01 16:40:46', 5250.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 5250.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 350, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-08-01 16:40:46', '2024-09-24 00:22:07'),
(89, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0286', '', NULL, NULL, NULL, '2024-08-12 23:37:46', 2625.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2625.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 175, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-08-12 17:37:46', '2024-09-24 00:26:24'),
(90, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0287', '', NULL, NULL, NULL, '2024-08-12 23:38:02', 3000.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-08-12 17:38:02', '2024-09-24 00:22:51'),
(91, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0288', '', NULL, NULL, NULL, '2024-08-12 23:38:15', 4500.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4500.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-08-12 17:38:15', '2024-09-24 00:25:49'),
(92, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 27, NULL, '0289', '', NULL, NULL, NULL, '2024-08-12 23:38:32', 6000.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 6000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 400, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-08-12 17:38:32', '2024-08-12 17:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_payments`
--

CREATE TABLE `transaction_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `is_return` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Used during sales to return the change',
  `amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `method` varchar(191) DEFAULT NULL,
  `payment_type` varchar(191) DEFAULT NULL,
  `transaction_no` varchar(191) DEFAULT NULL,
  `card_transaction_number` varchar(191) DEFAULT NULL,
  `card_number` varchar(191) DEFAULT NULL,
  `card_type` varchar(191) DEFAULT NULL,
  `card_holder_name` varchar(191) DEFAULT NULL,
  `card_month` varchar(191) DEFAULT NULL,
  `card_year` varchar(191) DEFAULT NULL,
  `card_security` varchar(5) DEFAULT NULL,
  `cheque_number` varchar(191) DEFAULT NULL,
  `bank_account_number` varchar(191) DEFAULT NULL,
  `paid_on` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `paid_through_link` tinyint(1) NOT NULL DEFAULT 0,
  `gateway` varchar(191) DEFAULT NULL,
  `is_advance` tinyint(1) NOT NULL DEFAULT 0,
  `payment_for` int(11) DEFAULT NULL COMMENT 'stores the contact id',
  `parent_id` int(11) DEFAULT NULL,
  `note` varchar(191) DEFAULT NULL,
  `document` varchar(191) DEFAULT NULL,
  `payment_ref_no` varchar(191) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_sell_lines`
--

CREATE TABLE `transaction_sell_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `secondary_unit_quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `quantity_returned` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `unit_price_before_discount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Sell price excluding tax',
  `line_discount_type` enum('fixed','percentage') DEFAULT NULL,
  `line_discount_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `unit_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `sell_line_note` text DEFAULT NULL,
  `so_line_id` int(11) DEFAULT NULL,
  `so_quantity_invoiced` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `res_service_staff_id` int(11) DEFAULT NULL,
  `res_line_order_status` varchar(191) DEFAULT NULL,
  `parent_sell_line_id` int(11) DEFAULT NULL,
  `children_type` varchar(191) NOT NULL DEFAULT '' COMMENT 'Type of children for the parent, like modifier or combo',
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_sell_lines_purchase_lines`
--

CREATE TABLE `transaction_sell_lines_purchase_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `sell_line_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'id from transaction_sell_lines',
  `stock_adjustment_line_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'id from stock_adjustment_lines',
  `purchase_line_id` int(10) UNSIGNED NOT NULL COMMENT 'id from purchase_lines',
  `quantity` decimal(22,4) NOT NULL,
  `qty_returned` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `types_of_services`
--

CREATE TABLE `types_of_services` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `location_price_group` text DEFAULT NULL,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') DEFAULT NULL,
  `enable_custom_fields` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `actual_name` varchar(191) NOT NULL,
  `short_name` varchar(191) NOT NULL,
  `allow_decimal` tinyint(1) NOT NULL,
  `base_unit_id` int(11) DEFAULT NULL,
  `base_unit_multiplier` decimal(20,4) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `business_id`, `actual_name`, `short_name`, `allow_decimal`, `base_unit_id`, `base_unit_multiplier`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Pieces', 'Pc(s)', 0, NULL, NULL, 1, NULL, '2023-02-23 22:00:02', '2023-02-23 22:00:02'),
(2, 1, 'Pot', 'Pot', 1, NULL, NULL, 1, NULL, '2023-08-28 15:12:05', '2023-08-28 15:12:05'),
(3, 1, 'KG', 'KG', 1, NULL, NULL, 1, NULL, '2023-08-29 05:31:26', '2023-08-29 05:31:26'),
(4, 1, '500 gm', '500 gm', 1, NULL, NULL, 1, NULL, '2023-08-29 05:39:56', '2023-08-29 05:39:56'),
(5, 1, 'Box', 'Box', 1, NULL, NULL, 1, NULL, '2023-08-29 06:24:26', '2023-08-29 06:24:26'),
(6, 1, 'Gm', 'Gm', 1, NULL, NULL, 1, NULL, '2023-09-14 06:25:40', '2023-09-14 06:25:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(191) NOT NULL DEFAULT 'user',
  `surname` char(10) DEFAULT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `username` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `referel_id` varchar(255) DEFAULT NULL,
  `refered_id` varchar(255) DEFAULT NULL,
  `depo_id` int(11) DEFAULT NULL,
  `language` char(7) NOT NULL DEFAULT 'en',
  `contact_no` char(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `rank_reward_point` varchar(255) DEFAULT NULL,
  `after_death_allowance` varchar(255) DEFAULT NULL,
  `company_profit_share` varchar(255) DEFAULT NULL,
  `company_fund` int(11) NOT NULL DEFAULT 0,
  `marketting_coast` varchar(255) DEFAULT NULL,
  `couriar_cost` varchar(255) DEFAULT NULL,
  `house_rent` varchar(255) DEFAULT NULL,
  `stokist_bonus` varchar(255) DEFAULT NULL,
  `stokist_refer_bonus` varchar(255) DEFAULT NULL,
  `depo_bonus` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `business_id` int(10) UNSIGNED DEFAULT NULL,
  `available_at` datetime DEFAULT NULL COMMENT 'Service staff avilable at. Calculated from product preparation_time_in_minutes',
  `paused_at` datetime DEFAULT NULL COMMENT 'Service staff available time paused at, Will be nulled on resume.',
  `max_sales_discount_percent` decimal(5,2) DEFAULT NULL,
  `allow_login` tinyint(1) NOT NULL DEFAULT 1,
  `status` enum('active','inactive','terminated') NOT NULL DEFAULT 'active',
  `crm_contact_id` int(10) UNSIGNED DEFAULT NULL,
  `is_cmmsn_agnt` tinyint(1) NOT NULL DEFAULT 0,
  `cmmsn_percent` decimal(4,2) NOT NULL DEFAULT 0.00,
  `selected_contacts` tinyint(1) NOT NULL DEFAULT 0,
  `dob` date DEFAULT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `marital_status` enum('married','unmarried','divorced') DEFAULT NULL,
  `blood_group` char(10) DEFAULT NULL,
  `contact_number` char(20) DEFAULT NULL,
  `alt_number` varchar(191) DEFAULT NULL,
  `family_number` varchar(191) DEFAULT NULL,
  `fb_link` varchar(191) DEFAULT NULL,
  `twitter_link` varchar(191) DEFAULT NULL,
  `social_media_1` varchar(191) DEFAULT NULL,
  `social_media_2` varchar(191) DEFAULT NULL,
  `permanent_address` text DEFAULT NULL,
  `current_address` text DEFAULT NULL,
  `guardian_name` varchar(191) DEFAULT NULL,
  `custom_field_1` varchar(191) DEFAULT NULL,
  `custom_field_2` varchar(191) DEFAULT NULL,
  `custom_field_3` varchar(191) DEFAULT NULL,
  `custom_field_4` varchar(191) DEFAULT NULL,
  `bank_details` longtext DEFAULT NULL,
  `id_proof_name` varchar(191) DEFAULT NULL,
  `id_proof_number` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_type`, `surname`, `first_name`, `last_name`, `username`, `email`, `password`, `referel_id`, `refered_id`, `depo_id`, `language`, `contact_no`, `address`, `rank_reward_point`, `after_death_allowance`, `company_profit_share`, `company_fund`, `marketting_coast`, `couriar_cost`, `house_rent`, `stokist_bonus`, `stokist_refer_bonus`, `depo_bonus`, `remember_token`, `business_id`, `available_at`, `paused_at`, `max_sales_discount_percent`, `allow_login`, `status`, `crm_contact_id`, `is_cmmsn_agnt`, `cmmsn_percent`, `selected_contacts`, `dob`, `gender`, `marital_status`, `blood_group`, `contact_number`, `alt_number`, `family_number`, `fb_link`, `twitter_link`, `social_media_1`, `social_media_2`, `permanent_address`, `current_address`, `guardian_name`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `bank_details`, `id_proof_name`, `id_proof_number`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'user', 'MR', 'SUPER', 'ADMIN', 'admin', 'admin@gmail.com', '$2y$12$HhBDIfLesSdhoD1X.gqTaOoIMwfhz.USEurCiwRDbyKmGQ2Nswm9.', NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL, 0, '0', '0', '0', NULL, '2', NULL, 'FPnFw0zrT4mtHfdursCYZXWwsh8augouWK8iVFJ4jUgPVA3VPKQgIhymDO0S', 1, NULL, NULL, NULL, 1, 'active', NULL, 0, 0.00, 0, '1986-11-15', 'male', 'married', 'o+', '01766855006', NULL, '01766509344', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":\"Razu\",\"account_number\":\"Ahmed\",\"bank_name\":\"Duch Bangla Bank\",\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, NULL, '2023-02-23 22:00:02', '2023-09-08 15:33:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_contact_access`
--

CREATE TABLE `user_contact_access` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_contact_access`
--

INSERT INTO `user_contact_access` (`id`, `user_id`, `contact_id`) VALUES
(1, 11, 107),
(2, 5, 108),
(3, 11, 1),
(4, 5, 2),
(5, 5, 3),
(6, 5, 4),
(7, 5, 5),
(8, 5, 6),
(9, 5, 7),
(10, 5, 8);

-- --------------------------------------------------------

--
-- Table structure for table `variations`
--

CREATE TABLE `variations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `sub_sku` varchar(191) DEFAULT NULL,
  `product_variation_id` int(10) UNSIGNED NOT NULL,
  `variation_value_id` int(11) DEFAULT NULL,
  `default_purchase_price` decimal(22,4) DEFAULT NULL,
  `dpp_inc_tax` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `profit_percent` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `default_sell_price` decimal(22,4) DEFAULT NULL,
  `sell_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `combo_variations` text DEFAULT NULL COMMENT 'Contains the combo variation details'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `variations`
--

INSERT INTO `variations` (`id`, `name`, `product_id`, `sub_sku`, `product_variation_id`, `variation_value_id`, `default_purchase_price`, `dpp_inc_tax`, `profit_percent`, `default_sell_price`, `sell_price_inc_tax`, `created_at`, `updated_at`, `deleted_at`, `combo_variations`) VALUES
(1, 'DUMMY', 231, '0085', 1, NULL, 100.0000, 100.0000, 10.0000, 130.0000, 130.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(2, 'DUMMY', 232, '0086', 2, NULL, 190.0000, 190.0000, 10.0000, 250.0000, 250.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(3, 'DUMMY', 233, '0087', 3, NULL, 625.0000, 625.0000, 20.0000, 750.0000, 750.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(4, 'DUMMY', 234, '0088', 4, NULL, 100.0000, 100.0000, 10.0000, 130.0000, 130.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(5, 'DUMMY', 235, '0089', 5, NULL, 200.0000, 200.0000, 10.0000, 250.0000, 250.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(6, 'DUMMY', 236, '0090', 6, NULL, 225.0000, 225.0000, 20.0000, 270.0000, 270.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(7, 'DUMMY', 237, '10035733', 7, NULL, 7.5000, 7.5000, 20.0000, 9.0000, 9.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(8, 'DUMMY', 238, '0093', 8, NULL, 540.0000, 540.0000, 10.0000, 690.0000, 690.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(9, 'DUMMY', 239, '45057731', 9, NULL, 300.0000, 300.0000, 25.0000, 375.0000, 375.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(10, 'DUMMY', 240, '0095', 10, NULL, 200.0000, 200.0000, 10.0000, 250.0000, 250.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(11, 'DUMMY', 241, '0096', 11, NULL, 480.0000, 480.0000, 10.0000, 600.0000, 600.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(12, 'DUMMY', 242, '0097', 12, NULL, 145.0000, 145.0000, 10.0000, 200.0000, 200.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(13, 'DUMMY', 243, '0098', 13, NULL, 280.0000, 280.0000, 10.0000, 380.0000, 380.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(14, 'DUMMY', 244, '0099', 14, NULL, 100.0000, 100.0000, 10.0000, 130.0000, 130.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(15, 'DUMMY', 245, '03048733', 15, NULL, 600.0000, 600.0000, 10.0000, 750.0000, 750.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(16, 'DUMMY', 246, '0101', 16, NULL, 28.0000, 28.0000, 30.9600, 36.6700, 36.6700, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(17, 'DUMMY', 247, '30640733', 17, NULL, 15.3400, 15.3400, 28.2300, 19.6700, 19.6700, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(18, 'DUMMY', 248, '0103', 18, NULL, 10.5000, 10.5000, 33.3300, 14.0000, 14.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(19, 'DUMMY', 249, '0104', 19, NULL, 20.0000, 20.0000, 20.0000, 24.0000, 24.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(20, 'DUMMY', 250, '0105', 20, NULL, 18.3300, 18.3300, 22.7496, 22.5000, 22.5000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(21, 'DUMMY', 251, '30063730', 21, NULL, 14.0000, 14.0000, 25.0000, 17.5000, 17.5000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(22, 'DUMMY', 252, '0107', 22, NULL, 420.0000, 420.0000, 10.0000, 525.0000, 525.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(23, 'DUMMY', 253, '0108', 23, NULL, 55.0000, 55.0000, 10.0000, 75.0000, 75.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(24, 'DUMMY', 254, '0109', 24, NULL, 105.0000, 105.0000, 10.0000, 140.0000, 140.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(25, 'DUMMY', 255, '0110', 25, NULL, 10.5000, 10.5000, 42.8600, 15.0000, 15.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(26, 'DUMMY', 256, '0111', 26, NULL, 315.0000, 315.0000, 42.8600, 450.0000, 450.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(27, 'DUMMY', 257, '0112', 27, NULL, 100.0000, 100.0000, 10.0000, 130.0000, 130.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(28, 'DUMMY', 258, '0113', 28, NULL, 190.0000, 190.0000, 10.0000, 250.0000, 250.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(29, 'DUMMY', 259, '0114', 29, NULL, 100.0000, 100.0000, 10.0000, 130.0000, 130.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(30, 'DUMMY', 260, '0115', 30, NULL, 180.0000, 180.0000, 10.0000, 230.0000, 230.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(31, 'DUMMY', 261, '0116', 31, NULL, 14.6700, 14.6700, 25.0200, 18.3400, 18.3400, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(32, 'DUMMY', 262, '0117', 32, NULL, 200.0000, 200.0000, 10.0000, 250.0000, 250.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(33, 'DUMMY', 263, '45054730', 33, NULL, 200.0000, 200.0000, 10.0000, 260.0000, 260.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(34, 'DUMMY', 264, '0119', 34, NULL, 17.5000, 17.5000, 42.8600, 25.0000, 25.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(35, 'DUMMY', 265, '0120', 35, NULL, 37.5000, 37.5000, 33.3300, 50.0000, 50.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(36, 'DUMMY', 266, '0121', 36, NULL, 160.0000, 160.0000, 10.0000, 200.0000, 200.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(37, 'DUMMY', 267, '0122', 37, NULL, 200.0000, 200.0000, 10.0000, 250.0000, 250.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(38, 'DUMMY', 268, '0123', 38, NULL, 400.0000, 400.0000, 10.0000, 500.0000, 500.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(39, 'DUMMY', 269, '45056734', 39, NULL, 275.0000, 275.0000, 10.0000, 350.0000, 350.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(40, 'DUMMY', 270, '0125', 40, NULL, 30.0000, 30.0000, 27.8000, 38.3400, 38.3400, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(41, 'DUMMY', 271, '0126', 41, NULL, 52.0000, 52.0000, 25.0000, 65.0000, 65.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(42, 'DUMMY', 272, '0127', 42, NULL, 45.0000, 45.0000, 27.7800, 57.5000, 57.5000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(43, 'DUMMY', 273, '0128', 43, NULL, 37.5000, 37.5000, 26.6700, 47.5000, 47.5000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(44, 'DUMMY', 274, '0129', 44, NULL, 12.5000, 12.5000, 28.0000, 16.0000, 16.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(45, 'DUMMY', 275, '0130', 45, NULL, 16.5000, 16.5000, 21.2100, 20.0000, 20.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(46, 'DUMMY', 276, '0131', 46, NULL, 16.5000, 16.5000, 21.2100, 20.0000, 20.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(47, 'DUMMY', 277, '0132', 47, NULL, 90.0000, 90.0000, 10.0000, 120.0000, 120.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(48, 'DUMMY', 278, '780404512521', 48, NULL, 140.0000, 140.0000, 10.0000, 175.0000, 175.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(49, 'DUMMY', 279, '0135', 49, NULL, 470.0000, 470.0000, 10.0000, 590.0000, 590.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(50, 'DUMMY', 280, '0136', 50, NULL, 52.0000, 52.0000, 25.0000, 65.0000, 65.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(51, 'DUMMY', 281, '0137', 51, NULL, 240.0000, 240.0000, 10.0000, 300.0000, 300.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(52, 'DUMMY', 282, '0138', 52, NULL, 16.0000, 16.0000, 25.0000, 20.0000, 20.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(53, 'DUMMY', 283, '0139', 53, NULL, 320.0000, 320.0000, 10.0000, 400.0000, 400.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(54, 'DUMMY', 284, '0140', 54, NULL, 100.0000, 100.0000, 25.0000, 125.0000, 125.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(55, 'DUMMY', 285, '0141', 55, NULL, 350.0000, 350.0000, 28.5700, 450.0000, 450.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(56, 'DUMMY', 286, '0142', 56, NULL, 300.0000, 300.0000, 10.0000, 375.0000, 375.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(57, 'DUMMY', 287, '0144', 57, NULL, 480.0000, 480.0000, 10.0000, 600.0000, 600.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(58, 'DUMMY', 288, '30050731', 58, NULL, 10.3300, 10.3300, 21.0100, 12.5000, 12.5000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(59, 'DUMMY', 289, '4116513030', 59, NULL, 19.0000, 19.0000, 15.7900, 22.0000, 22.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(60, 'DUMMY', 290, '4116513031', 60, NULL, 38.0000, 38.0000, 10.5300, 42.0000, 42.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(61, 'DUMMY', 291, '0148', 61, NULL, 25.0000, 25.0000, 20.0000, 30.0000, 30.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(62, 'DUMMY', 292, '8941100500415', 62, NULL, 88.0000, 88.0000, 13.6400, 100.0000, 100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(63, 'DUMMY', 293, '8941100500941', 63, NULL, 88.0000, 88.0000, 13.6400, 100.0000, 100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(64, 'DUMMY', 294, '8941100502617', 64, NULL, 90.0000, 90.0000, 55.5600, 140.0000, 140.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(65, 'DUMMY', 295, '8941100502587', 65, NULL, 130.0000, 130.0000, 80.7700, 235.0000, 235.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(66, 'DUMMY', 296, '8941196201418', 66, NULL, 90.0000, 90.0000, 55.5600, 140.0000, 140.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(67, 'DUMMY', 297, '8947760520121', 67, NULL, 520.0000, 520.0000, 32.6900, 690.0000, 690.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(68, 'DUMMY', 298, '8941193103111', 68, NULL, 18.0000, 18.0000, 38.8900, 25.0000, 25.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(69, 'DUMMY', 299, '0156', 69, NULL, 50.0000, 50.0000, 20.0000, 60.0000, 60.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(70, 'DUMMY', 300, '8941100281321', 70, NULL, 45.0000, 45.0000, 22.2200, 55.0000, 55.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(71, 'DUMMY', 301, '8941100283226', 71, NULL, 35.0000, 35.0000, 20.0000, 42.0000, 42.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(72, 'DUMMY', 302, '0159', 72, NULL, 18.0000, 18.0000, 261.1100, 65.0000, 65.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(73, 'DUMMY', 303, '1421622110', 73, NULL, 50.0000, 50.0000, 20.0000, 60.0000, 60.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(74, 'DUMMY', 304, '1421622112', 74, NULL, 100.0000, 100.0000, 20.0000, 120.0000, 120.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(75, 'DUMMY', 305, '1433623610', 75, NULL, 62.0000, 62.0000, 12.9000, 70.0000, 70.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(76, 'DUMMY', 306, '1439624404', 76, NULL, 41.0000, 41.0000, 12.2000, 46.0000, 46.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(77, 'DUMMY', 307, '1751622610', 77, NULL, 35.2000, 35.2000, 19.3182, 42.0000, 42.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(78, 'DUMMY', 308, '1254615910', 78, NULL, 165.0000, 165.0000, 2.4242, 169.0000, 169.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(79, 'DUMMY', 309, '1254615912', 79, NULL, 330.0000, 330.0000, 2.4242, 338.0000, 338.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(80, 'DUMMY', 310, '1254615923', 80, NULL, 805.0000, 805.0000, 2.4845, 825.0000, 825.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(81, 'DUMMY', 311, '0168', 81, NULL, 1400.0000, 1400.0000, 14.2900, 1600.0000, 1600.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(82, 'DUMMY', 312, '0169', 82, NULL, 1500.0000, 1500.0000, 12.0000, 1680.0000, 1680.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(83, 'DUMMY', 313, '0170', 83, NULL, 1420.0000, 1420.0000, 11.2700, 1580.0000, 1580.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(84, 'DUMMY', 314, '0171', 84, NULL, 1490.0000, 1490.0000, 11.4100, 1660.0000, 1660.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(85, 'DUMMY', 315, '0172', 85, NULL, 1230.0000, 1230.0000, 12.2000, 1380.0000, 1380.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(86, 'DUMMY', 316, '0173', 86, NULL, 1230.0000, 1230.0000, 10.5700, 1360.0000, 1360.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(87, 'DUMMY', 317, '0174', 87, NULL, 1270.0000, 1270.0000, 13.3900, 1440.0000, 1440.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(88, 'DUMMY', 318, '941193063026', 88, NULL, 55.0000, 55.0000, 36.3600, 75.0000, 75.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(89, 'DUMMY', 319, '941193063057', 89, NULL, 18.7500, 18.7500, 33.3300, 25.0000, 25.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(90, 'DUMMY', 320, '941193063118', 90, NULL, 7.9200, 7.9200, 26.2600, 10.0000, 10.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(91, 'DUMMY', 321, '941193077153', 91, NULL, 175.0000, 175.0000, 20.0000, 210.0000, 210.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(92, 'DUMMY', 322, '941193077108', 92, NULL, 175.0000, 175.0000, 20.0000, 210.0000, 210.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(93, 'DUMMY', 323, '941193077139', 93, NULL, 175.0000, 175.0000, 20.0000, 210.0000, 210.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(94, 'DUMMY', 324, '941193077115', 94, NULL, 175.0000, 175.0000, 20.0000, 210.0000, 210.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(95, 'DUMMY', 325, '941193077085', 95, NULL, 190.0000, 190.0000, 26.3200, 240.0000, 240.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(96, 'DUMMY', 326, '0183', 96, NULL, 52.0000, 52.0000, 92.3100, 100.0000, 100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(97, 'DUMMY', 327, '0184', 97, NULL, 35.0000, 35.0000, 71.4300, 60.0000, 60.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(98, 'DUMMY', 328, '60050731', 98, NULL, 620.0000, 620.0000, 19.3500, 740.0000, 740.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(99, 'DUMMY', 329, '0186', 99, NULL, 275.0000, 275.0000, 27.2700, 350.0000, 350.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(100, 'DUMMY', 330, '0187', 100, NULL, 490.0000, 490.0000, 42.8571, 700.0000, 700.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(101, 'DUMMY', 331, '0188', 101, NULL, 525.0000, 525.0000, 42.8571, 750.0000, 750.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(102, 'DUMMY', 332, '0189', 102, NULL, 595.0000, 595.0000, 42.8571, 850.0000, 850.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(103, 'DUMMY', 333, '0190', 103, NULL, 700.0000, 700.0000, 42.8571, 1000.0000, 1000.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(104, 'DUMMY', 334, '0191', 104, NULL, 770.0000, 770.0000, 42.8571, 1100.0000, 1100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(105, 'DUMMY', 335, '0192', 105, NULL, 875.0000, 875.0000, 42.8571, 1250.0000, 1250.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(106, 'DUMMY', 336, '0193', 106, NULL, 980.0000, 980.0000, 42.8571, 1400.0000, 1400.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(107, 'DUMMY', 337, '0194', 107, NULL, 665.0000, 665.0000, 42.8571, 950.0000, 950.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(108, 'DUMMY', 338, '0195', 108, NULL, 665.0000, 665.0000, 42.8571, 950.0000, 950.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(109, 'DUMMY', 339, '0196', 109, NULL, 350.0000, 350.0000, 42.8571, 500.0000, 500.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(110, 'DUMMY', 340, '0197', 110, NULL, 350.0000, 350.0000, 42.8571, 500.0000, 500.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(111, 'DUMMY', 341, '0198', 111, NULL, 525.0000, 525.0000, 42.8571, 750.0000, 750.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(112, 'DUMMY', 342, '0199', 112, NULL, 630.0000, 630.0000, 42.8571, 900.0000, 900.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(113, 'DUMMY', 343, '0200', 113, NULL, 1125.0000, 1125.0000, 11.1100, 1250.0000, 1250.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(114, 'DUMMY', 344, '0201', 114, NULL, 560.0000, 560.0000, 42.8571, 800.0000, 800.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(115, 'DUMMY', 345, '0202', 115, NULL, 735.0000, 735.0000, 42.8571, 1050.0000, 1050.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(116, 'DUMMY', 346, '0203', 116, NULL, 682.0000, 682.0000, 42.9619, 975.0000, 975.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(117, 'DUMMY', 347, '0204', 117, NULL, 1400.0000, 1400.0000, 42.8571, 2000.0000, 2000.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(118, 'DUMMY', 348, '0205', 118, NULL, 665.0000, 665.0000, 42.8571, 950.0000, 950.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(119, 'DUMMY', 349, '0206', 119, NULL, 42.0000, 42.0000, 42.8571, 60.0000, 60.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(120, 'DUMMY', 350, '0207', 120, NULL, 585.0000, 585.0000, 11.1100, 650.0000, 650.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(121, 'DUMMY', 351, '0208', 121, NULL, 770.0000, 770.0000, 42.8571, 1100.0000, 1100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(122, 'DUMMY', 352, '0209', 122, NULL, 735.0000, 735.0000, 42.8571, 1050.0000, 1050.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(123, 'DUMMY', 353, '0210', 123, NULL, 892.0000, 892.0000, 42.9372, 1275.0000, 1275.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(124, 'DUMMY', 354, '0211', 124, NULL, 770.0000, 770.0000, 42.8571, 1100.0000, 1100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(125, 'DUMMY', 355, '0212', 125, NULL, 1120.0000, 1120.0000, 42.8571, 1600.0000, 1600.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(126, 'DUMMY', 356, '0213', 126, NULL, 700.0000, 700.0000, 42.8571, 1000.0000, 1000.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(127, 'DUMMY', 357, '0214', 127, NULL, 450.0000, 450.0000, 11.1100, 500.0000, 500.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(128, 'DUMMY', 358, '0215', 128, NULL, 770.0000, 770.0000, 42.8571, 1100.0000, 1100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(129, 'DUMMY', 359, '0216', 129, NULL, 630.0000, 630.0000, 42.8571, 900.0000, 900.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(130, 'DUMMY', 360, '0217', 130, NULL, 630.0000, 630.0000, 42.8571, 900.0000, 900.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(131, 'DUMMY', 361, '0218', 131, NULL, 665.0000, 665.0000, 42.8571, 950.0000, 950.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(132, 'DUMMY', 362, '0219', 132, NULL, 80.0000, 80.0000, 12.5000, 90.0000, 90.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(133, 'DUMMY', 363, '0220', 133, NULL, 90.0000, 90.0000, 22.2222, 110.0000, 110.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(134, 'DUMMY', 364, '10', 134, NULL, 125.0000, 125.0000, 12.0000, 140.0000, 140.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(135, 'DUMMY', 365, '0222', 135, NULL, 90.0000, 90.0000, 11.1100, 100.0000, 100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(136, 'DUMMY', 366, '0223', 136, NULL, 160.0000, 160.0000, 6.2500, 170.0000, 170.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(137, 'DUMMY', 367, '0224', 137, NULL, 100.0000, 100.0000, 10.0000, 110.0000, 110.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(138, 'DUMMY', 368, '0225', 138, NULL, 80.0000, 80.0000, 37.5000, 110.0000, 110.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(139, 'DUMMY', 369, '0226', 139, NULL, 130.0000, 130.0000, 15.3800, 150.0000, 150.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(140, 'DUMMY', 370, '0227', 140, NULL, 100.0000, 100.0000, 40.0000, 140.0000, 140.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(141, 'DUMMY', 371, '0228', 141, NULL, 80.0000, 80.0000, 75.0000, 140.0000, 140.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(142, 'DUMMY', 372, '0229', 142, NULL, 80.0000, 80.0000, 25.0000, 100.0000, 100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(143, 'DUMMY', 373, '0230', 143, NULL, 80.0000, 80.0000, 25.0000, 100.0000, 100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(144, 'DUMMY', 374, '0231', 144, NULL, 80.0000, 80.0000, 25.0000, 100.0000, 100.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(145, 'DUMMY', 375, '0232', 145, NULL, 55.0000, 55.0000, 9.0900, 60.0000, 60.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(146, 'DUMMY', 376, '0233', 146, NULL, 22.0000, 22.0000, 9.0900, 24.0000, 24.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(147, 'DUMMY', 377, '0234', 147, NULL, 120.0000, 120.0000, 41.6667, 170.0000, 170.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(148, 'DUMMY', 378, '0235', 148, NULL, 220.0000, 220.0000, 45.4500, 320.0000, 320.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(149, 'DUMMY', 379, '0236', 149, NULL, 400.0000, 400.0000, 25.0000, 500.0000, 500.0000, '2024-07-14 10:39:18', '2024-07-14 10:39:18', NULL, '[]'),
(150, 'DUMMY', 380, '0237', 150, NULL, 500.0000, 500.0000, 50.0000, 750.0000, 750.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(151, 'DUMMY', 381, '0238', 151, NULL, 70.0000, 70.0000, 14.2900, 80.0000, 80.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(152, 'DUMMY', 382, '0239', 152, NULL, 160.0000, 160.0000, 12.5000, 180.0000, 180.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(153, 'DUMMY', 383, '0240', 153, NULL, 230.0000, 230.0000, 8.7000, 250.0000, 250.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(154, 'DUMMY', 384, '0241', 154, NULL, 450.0000, 450.0000, 4.4400, 470.0000, 470.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(155, 'DUMMY', 385, '0242', 155, NULL, 1050.0000, 1050.0000, 14.2900, 1200.0000, 1200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(156, 'DUMMY', 386, '0243', 156, NULL, 210.0000, 210.0000, 66.6667, 350.0000, 350.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(157, 'DUMMY', 387, '0244', 157, NULL, 270.0000, 270.0000, 11.1100, 300.0000, 300.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(158, 'DUMMY', 388, '0245', 158, NULL, 270.0000, 270.0000, 11.1100, 300.0000, 300.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(159, 'DUMMY', 389, '0246', 159, NULL, 225.0000, 225.0000, 2.2200, 230.0000, 230.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(160, 'DUMMY', 390, '0247', 160, NULL, 110.0000, 110.0000, 9.0900, 120.0000, 120.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(161, 'DUMMY', 391, '0248', 161, NULL, 200.0000, 200.0000, 15.0000, 230.0000, 230.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(162, 'DUMMY', 392, '0249', 162, NULL, 400.0000, 400.0000, 50.0000, 600.0000, 600.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(163, 'DUMMY', 393, '0250', 163, NULL, 400.0000, 400.0000, 50.0000, 600.0000, 600.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(164, 'DUMMY', 394, '0251', 164, NULL, 350.0000, 350.0000, 37.1400, 480.0000, 480.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(165, 'DUMMY', 395, '0252', 165, NULL, 180.0000, 180.0000, 38.8900, 250.0000, 250.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(166, 'DUMMY', 396, '0253', 166, NULL, 180.0000, 180.0000, 38.8900, 250.0000, 250.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(167, 'DUMMY', 397, '0254', 167, NULL, 350.0000, 350.0000, 37.1400, 480.0000, 480.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(168, 'DUMMY', 398, '0255', 168, NULL, 400.0000, 400.0000, 187.5000, 1150.0000, 1150.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(169, 'DUMMY', 399, '0256', 169, NULL, 400.0000, 400.0000, 25.0000, 500.0000, 500.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(170, 'DUMMY', 400, '0257', 170, NULL, 400.0000, 400.0000, 87.5000, 750.0000, 750.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(171, 'DUMMY', 401, '0258', 171, NULL, 300.0000, 300.0000, 50.0000, 450.0000, 450.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(172, 'DUMMY', 402, '0259', 172, NULL, 300.0000, 300.0000, 50.0000, 450.0000, 450.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(173, 'DUMMY', 403, '0260', 173, NULL, 1080.0000, 1080.0000, 11.1100, 1200.0000, 1200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(174, 'DUMMY', 404, '0261', 174, NULL, 1701.0000, 1701.0000, 11.1100, 1890.0000, 1890.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(175, 'DUMMY', 405, '0262', 175, NULL, 100.0000, 100.0000, 60.0000, 160.0000, 160.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(176, 'DUMMY', 406, '0263', 176, NULL, 200.0000, 200.0000, 80.0000, 360.0000, 360.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(177, 'DUMMY', 407, '0264', 177, NULL, 500.0000, 500.0000, 44.0000, 720.0000, 720.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(178, 'DUMMY', 408, '0265', 178, NULL, 700.0000, 700.0000, 64.2900, 1150.0000, 1150.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(179, 'DUMMY', 409, '0266', 179, NULL, 630.0000, 630.0000, 42.8571, 900.0000, 900.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(180, 'DUMMY', 410, '0267', 180, NULL, 280.0000, 280.0000, 42.8571, 400.0000, 400.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(181, 'DUMMY', 411, '0268', 181, NULL, 350.0000, 350.0000, 42.8571, 500.0000, 500.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(182, 'DUMMY', 412, '0269', 182, NULL, 198.0000, 198.0000, 11.1100, 220.0000, 220.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(183, 'DUMMY', 413, '0270', 183, NULL, 280.0000, 280.0000, 60.7143, 450.0000, 450.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(184, 'DUMMY', 414, '0271', 184, NULL, 123.0000, 123.0000, 42.2764, 175.0000, 175.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(185, 'DUMMY', 415, '808631857795', 185, NULL, 40.0000, 40.0000, 25.0000, 50.0000, 50.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(186, 'DUMMY', 416, '0273', 186, NULL, 300.0000, 300.0000, 16.6700, 350.0000, 350.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(187, 'DUMMY', 417, '0274', 187, NULL, 145.0000, 145.0000, 25.0000, 145.0000, 145.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(188, 'DUMMY', 418, '941100510056', 188, NULL, 240.0000, 240.0000, 25.0000, 240.0000, 240.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(189, 'DUMMY', 419, '941100510285', 189, NULL, 290.0000, 290.0000, 25.0000, 290.0000, 290.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(190, 'DUMMY', 420, '941100510261', 190, NULL, 115.0000, 115.0000, 25.0000, 115.0000, 115.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(191, 'DUMMY', 421, '0278', 191, NULL, 127.0000, 127.0000, 25.0000, 127.0000, 127.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(192, 'DUMMY', 422, '0279', 192, NULL, 32.6700, 32.6700, 42.8672, 46.6700, 46.6700, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(193, 'DUMMY', 423, '0280', 193, NULL, 210.0000, 210.0000, 42.8571, 300.0000, 300.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(194, 'DUMMY', 424, '0281', 194, NULL, 840.0000, 840.0000, 25.0000, 1050.0000, 1050.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(195, 'DUMMY', 425, '0282', 195, NULL, 420.0000, 420.0000, 28.5700, 540.0000, 540.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(196, 'DUMMY', 426, '0283', 196, NULL, 22.5000, 22.5000, 55.5600, 35.0000, 35.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(197, 'DUMMY', 427, '0286', 197, NULL, 22.5000, 22.5000, 55.5600, 35.0000, 35.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(198, 'DUMMY', 428, '0287', 198, NULL, 56.0000, 56.0000, 51.7900, 85.0000, 85.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(199, 'DUMMY', 429, '0288', 199, NULL, 112.0000, 112.0000, 51.7900, 170.0000, 170.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(200, 'DUMMY', 430, '0289', 200, NULL, 215.0000, 215.0000, 62.7900, 350.0000, 350.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(201, 'DUMMY', 431, '011390350018', 201, NULL, 10.0000, 10.0000, 50.0000, 15.0000, 15.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(202, 'DUMMY', 432, '0291', 202, NULL, 80.0000, 80.0000, 25.0000, 100.0000, 100.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(203, 'DUMMY', 433, '0292', 203, NULL, 80.0000, 80.0000, 25.0000, 100.0000, 100.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(204, 'DUMMY', 434, '0293', 204, NULL, 250.0000, 250.0000, 20.0000, 300.0000, 300.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(205, 'DUMMY', 435, '0294', 205, NULL, 200.0000, 200.0000, 50.0000, 300.0000, 300.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(206, 'DUMMY', 436, '0295', 206, NULL, 945.0000, 945.0000, 42.8571, 1350.0000, 1350.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(207, 'DUMMY', 437, '0296', 207, NULL, 805.0000, 805.0000, 42.8571, 1150.0000, 1150.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(208, 'DUMMY', 438, '0297', 208, NULL, 840.0000, 840.0000, 42.8571, 1200.0000, 1200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(209, 'DUMMY', 439, '1841626210', 209, NULL, 142.0000, 142.0000, 19.7200, 170.0000, 170.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(210, 'DUMMY', 440, '3050625010', 210, NULL, 113.0000, 113.0000, 6.1900, 120.0000, 120.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(211, 'DUMMY', 441, '0300', 211, NULL, 1050.0000, 1050.0000, 42.8571, 1500.0000, 1500.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(212, 'DUMMY', 442, '0301', 212, NULL, 665.0000, 665.0000, 42.8600, 950.0000, 950.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(213, 'DUMMY', 443, '0302', 213, NULL, 682.0000, 682.0000, 42.9600, 975.0000, 975.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(214, 'DUMMY', 444, '0303', 214, NULL, 2100.0000, 2100.0000, 42.8600, 3000.0000, 3000.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(215, 'DUMMY', 445, '0304', 215, NULL, 980.0000, 980.0000, 42.8600, 1400.0000, 1400.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(216, 'DUMMY', 446, '0305', 216, NULL, 2100.0000, 2100.0000, 42.8600, 3000.0000, 3000.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(217, 'DUMMY', 447, '0306', 217, NULL, 840.0000, 840.0000, 42.8600, 1200.0000, 1200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(218, 'DUMMY', 448, '0307', 218, NULL, 1220.0000, 1220.0000, 2.4590, 1250.0000, 1250.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(219, 'DUMMY', 449, '0308', 219, NULL, 245.0000, 245.0000, 42.8600, 350.0000, 350.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(220, 'DUMMY', 450, '0309', 220, NULL, 700.0000, 700.0000, 42.8600, 1000.0000, 1000.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(221, 'DUMMY', 451, '0310', 221, NULL, 805.0000, 805.0000, 42.8600, 1150.0000, 1150.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(222, 'DUMMY', 452, '0311', 222, NULL, 336.0000, 336.0000, 185.7100, 960.0000, 960.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(223, 'DUMMY', 453, '0312', 223, NULL, 420.0000, 420.0000, 42.8600, 600.0000, 600.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(224, 'DUMMY', 454, '0313', 224, NULL, 525.0000, 525.0000, 42.8600, 750.0000, 750.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(225, 'DUMMY', 455, '0314', 225, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(226, 'DUMMY', 456, '0315', 226, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(227, 'DUMMY', 457, '0316', 227, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(228, 'DUMMY', 458, '0317', 228, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(229, 'DUMMY', 459, '0318', 229, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(230, 'DUMMY', 460, '00000001', 230, NULL, 100.0000, 100.0000, 10.0000, 110.0000, 110.0000, '2024-07-14 10:39:19', '2024-07-14 10:39:19', NULL, '[]'),
(231, 'DUMMY', 461, '0085', 231, NULL, 65.0000, 65.0000, 10.0000, 130.0000, 130.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(232, 'DUMMY', 462, '0086', 232, NULL, 123.0000, 123.0000, 10.0000, 250.0000, 250.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(233, 'DUMMY', 463, '0087', 233, NULL, 406.0000, 406.0000, 20.0000, 750.0000, 750.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(234, 'DUMMY', 464, '0088', 234, NULL, 65.0000, 65.0000, 10.0000, 130.0000, 130.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(235, 'DUMMY', 465, '0089', 235, NULL, 130.0000, 130.0000, 10.0000, 250.0000, 250.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(236, 'DUMMY', 466, '0090', 236, NULL, 146.0000, 146.0000, 20.0000, 270.0000, 270.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(237, 'DUMMY', 467, '10035733', 237, NULL, 4.8800, 4.8800, 20.0000, 9.0000, 9.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(238, 'DUMMY', 468, '0093', 238, NULL, 351.0000, 351.0000, 10.0000, 690.0000, 690.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(239, 'DUMMY', 469, '45057731', 239, NULL, 195.0000, 195.0000, 25.0000, 375.0000, 375.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(240, 'DUMMY', 470, '0095', 240, NULL, 130.0000, 130.0000, 10.0000, 250.0000, 250.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(241, 'DUMMY', 471, '0096', 241, NULL, 312.0000, 312.0000, 10.0000, 600.0000, 600.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(242, 'DUMMY', 472, '0097', 242, NULL, 94.0000, 94.0000, 10.0000, 200.0000, 200.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(243, 'DUMMY', 473, '0098', 243, NULL, 182.0000, 182.0000, 10.0000, 380.0000, 380.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(244, 'DUMMY', 474, '0099', 244, NULL, 65.0000, 65.0000, 10.0000, 130.0000, 130.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(245, 'DUMMY', 475, '03048733', 245, NULL, 390.0000, 390.0000, 10.0000, 750.0000, 750.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(246, 'DUMMY', 476, '0101', 246, NULL, 18.0000, 18.0000, 30.9600, 36.6700, 36.6700, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(247, 'DUMMY', 477, '30640733', 247, NULL, 9.9800, 9.9800, 28.2300, 19.6700, 19.6700, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(248, 'DUMMY', 478, '0103', 248, NULL, 6.8300, 6.8300, 33.3300, 14.0000, 14.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(249, 'DUMMY', 479, '0104', 249, NULL, 13.0000, 13.0000, 20.0000, 24.0000, 24.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(250, 'DUMMY', 480, '0105', 250, NULL, 11.9200, 11.9200, 22.7496, 22.5000, 22.5000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(251, 'DUMMY', 481, '30063730', 251, NULL, 9.0200, 9.0200, 25.0000, 17.5000, 17.5000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(252, 'DUMMY', 482, '0107', 252, NULL, 273.0000, 273.0000, 10.0000, 525.0000, 525.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(253, 'DUMMY', 483, '0108', 253, NULL, 42.2500, 42.2500, 10.0000, 75.0000, 75.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(254, 'DUMMY', 484, '0109', 254, NULL, 68.2500, 68.2500, 10.0000, 140.0000, 140.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(255, 'DUMMY', 485, '0110', 255, NULL, 6.8200, 6.8200, 42.8600, 15.0000, 15.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(256, 'DUMMY', 486, '0111', 256, NULL, 205.0000, 205.0000, 42.8600, 450.0000, 450.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(257, 'DUMMY', 487, '0112', 257, NULL, 65.0000, 65.0000, 10.0000, 130.0000, 130.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(258, 'DUMMY', 488, '0113', 258, NULL, 124.0000, 124.0000, 10.0000, 250.0000, 250.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(259, 'DUMMY', 489, '0114', 259, NULL, 65.0000, 65.0000, 10.0000, 130.0000, 130.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(260, 'DUMMY', 490, '0115', 260, NULL, 117.0000, 117.0000, 10.0000, 230.0000, 230.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(261, 'DUMMY', 491, '0116', 261, NULL, 9.5400, 9.5400, 25.0200, 18.3400, 18.3400, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(262, 'DUMMY', 492, '0117', 262, NULL, 130.0000, 130.0000, 10.0000, 250.0000, 250.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(263, 'DUMMY', 493, '45054730', 263, NULL, 130.0000, 130.0000, 10.0000, 260.0000, 260.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(264, 'DUMMY', 494, '0119', 264, NULL, 11.3800, 11.3800, 42.8600, 25.0000, 25.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(265, 'DUMMY', 495, '0120', 265, NULL, 24.5000, 24.5000, 33.3300, 50.0000, 50.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(266, 'DUMMY', 496, '0121', 266, NULL, 104.0000, 104.0000, 10.0000, 200.0000, 200.0000, '2024-07-15 20:53:25', '2024-07-15 20:53:25', NULL, '[]'),
(267, 'DUMMY', 497, '0122', 267, NULL, 130.0000, 130.0000, 10.0000, 250.0000, 250.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(268, 'DUMMY', 498, '0123', 268, NULL, 260.0000, 260.0000, 10.0000, 500.0000, 500.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(269, 'DUMMY', 499, '45056734', 269, NULL, 179.0000, 179.0000, 10.0000, 350.0000, 350.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(270, 'DUMMY', 500, '0125', 270, NULL, 20.0000, 20.0000, 27.8000, 38.3400, 38.3400, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(271, 'DUMMY', 501, '0126', 271, NULL, 34.0000, 34.0000, 25.0000, 65.0000, 65.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(272, 'DUMMY', 502, '0127', 272, NULL, 29.2500, 29.2500, 27.7800, 57.5000, 57.5000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(273, 'DUMMY', 503, '0128', 273, NULL, 24.3800, 24.3800, 26.6700, 47.5000, 47.5000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(274, 'DUMMY', 504, '0129', 274, NULL, 8.2500, 8.2500, 28.0000, 16.0000, 16.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(275, 'DUMMY', 505, '0130', 275, NULL, 10.7500, 10.7500, 21.2100, 20.0000, 20.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(276, 'DUMMY', 506, '0131', 276, NULL, 10.7500, 10.7500, 21.2100, 20.0000, 20.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(277, 'DUMMY', 507, '0132', 277, NULL, 58.5000, 58.5000, 10.0000, 120.0000, 120.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(278, 'DUMMY', 508, '780405000000', 278, NULL, 91.0000, 91.0000, 10.0000, 175.0000, 175.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(279, 'DUMMY', 509, '0135', 279, NULL, 306.0000, 306.0000, 10.0000, 590.0000, 590.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(280, 'DUMMY', 510, '0136', 280, NULL, 33.9000, 33.9000, 25.0000, 65.0000, 65.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(281, 'DUMMY', 511, '0137', 281, NULL, 156.0000, 156.0000, 10.0000, 300.0000, 300.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(282, 'DUMMY', 512, '0138', 282, NULL, 10.5000, 10.5000, 25.0000, 20.0000, 20.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(283, 'DUMMY', 513, '0139', 283, NULL, 208.0000, 208.0000, 10.0000, 400.0000, 400.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(284, 'DUMMY', 514, '0140', 284, NULL, 65.0000, 65.0000, 25.0000, 125.0000, 125.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(285, 'DUMMY', 515, '0141', 285, NULL, 228.0000, 228.0000, 28.5700, 450.0000, 450.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(286, 'DUMMY', 516, '0142', 286, NULL, 195.0000, 195.0000, 10.0000, 375.0000, 375.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(287, 'DUMMY', 517, '0144', 287, NULL, 312.0000, 312.0000, 10.0000, 600.0000, 600.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(288, 'DUMMY', 518, '30050731', 288, NULL, 7.8000, 7.8000, 21.0100, 15.0000, 15.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(289, 'DUMMY', 519, '1421622110', 289, NULL, 50.0000, 50.0000, 20.0000, 60.0000, 60.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(290, 'DUMMY', 520, '1421622112', 290, NULL, 100.0000, 100.0000, 20.0000, 120.0000, 120.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(291, 'DUMMY', 521, '1433623610', 291, NULL, 62.0000, 62.0000, 12.9000, 70.0000, 70.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(292, 'DUMMY', 522, '1439624404', 292, NULL, 41.0000, 41.0000, 12.2000, 46.0000, 46.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(293, 'DUMMY', 523, '1751622610', 293, NULL, 35.2000, 35.2000, 19.3182, 42.0000, 42.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(294, 'DUMMY', 524, '1254615910', 294, NULL, 165.0000, 165.0000, 2.4242, 169.0000, 169.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(295, 'DUMMY', 525, '1254615912', 295, NULL, 330.0000, 330.0000, 2.4242, 338.0000, 338.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(296, 'DUMMY', 526, '1254615923', 296, NULL, 805.0000, 805.0000, 2.4845, 825.0000, 825.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(297, 'DUMMY', 527, '60050731', 297, NULL, 488.0000, 488.0000, 19.3500, 950.0000, 950.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(298, 'DUMMY', 528, '0186', 298, NULL, 179.0000, 179.0000, 27.2700, 350.0000, 350.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(299, 'DUMMY', 529, '0187', 299, NULL, 490.0000, 490.0000, 42.8571, 700.0000, 700.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(300, 'DUMMY', 530, '0188', 300, NULL, 525.0000, 525.0000, 42.8571, 750.0000, 750.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(301, 'DUMMY', 531, '0189', 301, NULL, 595.0000, 595.0000, 42.8571, 850.0000, 850.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(302, 'DUMMY', 532, '0190', 302, NULL, 700.0000, 700.0000, 42.8571, 1000.0000, 1000.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(303, 'DUMMY', 533, '0191', 303, NULL, 770.0000, 770.0000, 42.8571, 1100.0000, 1100.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(304, 'DUMMY', 534, '0192', 304, NULL, 875.0000, 875.0000, 42.8571, 1250.0000, 1250.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(305, 'DUMMY', 535, '0193', 305, NULL, 980.0000, 980.0000, 42.8571, 1400.0000, 1400.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(306, 'DUMMY', 536, '0194', 306, NULL, 665.0000, 665.0000, 42.8571, 950.0000, 950.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(307, 'DUMMY', 537, '0195', 307, NULL, 665.0000, 665.0000, 42.8571, 950.0000, 950.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(308, 'DUMMY', 538, '0196', 308, NULL, 350.0000, 350.0000, 42.8571, 500.0000, 500.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(309, 'DUMMY', 539, '0197', 309, NULL, 350.0000, 350.0000, 42.8571, 500.0000, 500.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(310, 'DUMMY', 540, '0198', 310, NULL, 525.0000, 525.0000, 42.8571, 750.0000, 750.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(311, 'DUMMY', 541, '0199', 311, NULL, 630.0000, 630.0000, 42.8571, 900.0000, 900.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(312, 'DUMMY', 542, '0200', 312, NULL, 1125.0000, 1125.0000, 11.1100, 1250.0000, 1250.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(313, 'DUMMY', 543, '0201', 313, NULL, 560.0000, 560.0000, 42.8571, 800.0000, 800.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(314, 'DUMMY', 544, '0202', 314, NULL, 735.0000, 735.0000, 42.8571, 1050.0000, 1050.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(315, 'DUMMY', 545, '0203', 315, NULL, 682.0000, 682.0000, 42.9619, 975.0000, 975.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(316, 'DUMMY', 546, '0204', 316, NULL, 1400.0000, 1400.0000, 42.8571, 2000.0000, 2000.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(317, 'DUMMY', 547, '0205', 317, NULL, 665.0000, 665.0000, 42.8571, 950.0000, 950.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(318, 'DUMMY', 548, '0206', 318, NULL, 42.0000, 42.0000, 42.8571, 60.0000, 60.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(319, 'DUMMY', 549, '0207', 319, NULL, 585.0000, 585.0000, 11.1100, 650.0000, 650.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(320, 'DUMMY', 550, '0208', 320, NULL, 770.0000, 770.0000, 42.8571, 1100.0000, 1100.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(321, 'DUMMY', 551, '0209', 321, NULL, 735.0000, 735.0000, 42.8571, 1050.0000, 1050.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(322, 'DUMMY', 552, '0210', 322, NULL, 892.0000, 892.0000, 42.9372, 1275.0000, 1275.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(323, 'DUMMY', 553, '0211', 323, NULL, 770.0000, 770.0000, 42.8571, 1100.0000, 1100.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(324, 'DUMMY', 554, '0212', 324, NULL, 1120.0000, 1120.0000, 42.8571, 1600.0000, 1600.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(325, 'DUMMY', 555, '0213', 325, NULL, 700.0000, 700.0000, 42.8571, 1000.0000, 1000.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(326, 'DUMMY', 556, '0214', 326, NULL, 450.0000, 450.0000, 11.1100, 500.0000, 500.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(327, 'DUMMY', 557, '0215', 327, NULL, 770.0000, 770.0000, 42.8571, 1100.0000, 1100.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(328, 'DUMMY', 558, '0216', 328, NULL, 630.0000, 630.0000, 42.8571, 900.0000, 900.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(329, 'DUMMY', 559, '0217', 329, NULL, 630.0000, 630.0000, 42.8571, 900.0000, 900.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(330, 'DUMMY', 560, '0218', 330, NULL, 665.0000, 665.0000, 42.8571, 950.0000, 950.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(331, 'DUMMY', 561, '0260', 331, NULL, 1080.0000, 1080.0000, 11.1100, 1200.0000, 1200.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(332, 'DUMMY', 562, '0261', 332, NULL, 1701.0000, 1701.0000, 11.1100, 1890.0000, 1890.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(333, 'DUMMY', 563, '0266', 333, NULL, 630.0000, 630.0000, 42.8571, 900.0000, 900.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(334, 'DUMMY', 564, '0267', 334, NULL, 280.0000, 280.0000, 42.8571, 400.0000, 400.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(335, 'DUMMY', 565, '0268', 335, NULL, 350.0000, 350.0000, 42.8571, 500.0000, 500.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(336, 'DUMMY', 566, '0269', 336, NULL, 198.0000, 198.0000, 11.1100, 220.0000, 220.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(337, 'DUMMY', 567, '0270', 337, NULL, 280.0000, 280.0000, 60.7143, 450.0000, 450.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(338, 'DUMMY', 568, '0271', 338, NULL, 123.0000, 123.0000, 42.2764, 175.0000, 175.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(339, 'DUMMY', 569, '0279', 339, NULL, 32.6700, 32.6700, 42.8672, 46.6700, 46.6700, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(340, 'DUMMY', 570, '0280', 340, NULL, 210.0000, 210.0000, 42.8571, 300.0000, 300.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(341, 'DUMMY', 571, '0281', 341, NULL, 546.0000, 546.0000, 25.0000, 1050.0000, 1050.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(342, 'DUMMY', 572, '0282', 342, NULL, 273.0000, 273.0000, 28.5700, 540.0000, 540.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(343, 'DUMMY', 573, '0295', 343, NULL, 945.0000, 945.0000, 42.8571, 1350.0000, 1350.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]');
INSERT INTO `variations` (`id`, `name`, `product_id`, `sub_sku`, `product_variation_id`, `variation_value_id`, `default_purchase_price`, `dpp_inc_tax`, `profit_percent`, `default_sell_price`, `sell_price_inc_tax`, `created_at`, `updated_at`, `deleted_at`, `combo_variations`) VALUES
(344, 'DUMMY', 574, '0296', 344, NULL, 805.0000, 805.0000, 42.8571, 1150.0000, 1150.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(345, 'DUMMY', 575, '0297', 345, NULL, 840.0000, 840.0000, 42.8571, 1200.0000, 1200.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(346, 'DUMMY', 576, '1841626210', 346, NULL, 142.0000, 142.0000, 19.7200, 170.0000, 170.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(347, 'DUMMY', 577, '3050625010', 347, NULL, 113.0000, 113.0000, 6.1900, 120.0000, 120.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(348, 'DUMMY', 578, '0300', 348, NULL, 1050.0000, 1050.0000, 42.8571, 1500.0000, 1500.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(349, 'DUMMY', 579, '0301', 349, NULL, 665.0000, 665.0000, 42.8600, 950.0000, 950.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(350, 'DUMMY', 580, '0302', 350, NULL, 682.0000, 682.0000, 42.9600, 975.0000, 975.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(351, 'DUMMY', 581, '0303', 351, NULL, 2100.0000, 2100.0000, 42.8600, 3000.0000, 3000.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(352, 'DUMMY', 582, '0304', 352, NULL, 980.0000, 980.0000, 42.8600, 1400.0000, 1400.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(353, 'DUMMY', 583, '0305', 353, NULL, 2100.0000, 2100.0000, 42.8600, 3000.0000, 3000.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(354, 'DUMMY', 584, '0307', 354, NULL, 1220.0000, 1220.0000, 2.4590, 1250.0000, 1250.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(355, 'DUMMY', 585, '0308', 355, NULL, 245.0000, 245.0000, 42.8600, 350.0000, 350.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(356, 'DUMMY', 586, '0309', 356, NULL, 700.0000, 700.0000, 42.8600, 1000.0000, 1000.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(357, 'DUMMY', 587, '0310', 357, NULL, 805.0000, 805.0000, 42.8600, 1150.0000, 1150.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(358, 'DUMMY', 588, '0311', 358, NULL, 336.0000, 336.0000, 185.7100, 960.0000, 960.0000, '2024-07-15 20:53:26', '2024-07-15 20:53:26', NULL, '[]'),
(359, 'DUMMY', 589, '0312', 359, NULL, 420.0000, 420.0000, 42.8600, 600.0000, 600.0000, '2024-07-15 20:53:27', '2024-07-15 20:53:27', NULL, '[]'),
(360, 'DUMMY', 590, '0313', 360, NULL, 525.0000, 525.0000, 42.8600, 750.0000, 750.0000, '2024-07-15 20:53:27', '2024-07-15 20:53:27', NULL, '[]'),
(361, 'DUMMY', 591, '0314', 361, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-15 20:53:27', '2024-07-15 20:53:27', NULL, '[]'),
(362, 'DUMMY', 592, '0315', 362, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-15 20:53:27', '2024-07-15 20:53:27', NULL, '[]'),
(363, 'DUMMY', 593, '0316', 363, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-15 20:53:27', '2024-07-15 20:53:27', NULL, '[]'),
(364, 'DUMMY', 594, '0317', 364, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-15 20:53:27', '2024-07-15 20:53:27', NULL, '[]'),
(365, 'DUMMY', 595, '0318', 365, NULL, 140.0000, 140.0000, 42.8600, 200.0000, 200.0000, '2024-07-15 20:53:27', '2024-07-15 20:53:27', NULL, '[]');

-- --------------------------------------------------------

--
-- Table structure for table `variation_group_prices`
--

CREATE TABLE `variation_group_prices` (
  `id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `price_group_id` int(10) UNSIGNED NOT NULL,
  `price_inc_tax` decimal(22,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variation_location_details`
--

CREATE TABLE `variation_location_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_variation_id` int(10) UNSIGNED NOT NULL COMMENT 'id from product_variations table',
  `variation_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `qty_available` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variation_templates`
--

CREATE TABLE `variation_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variation_value_templates`
--

CREATE TABLE `variation_value_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `variation_template_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warranties`
--

CREATE TABLE `warranties` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `duration_type` enum('days','months','years') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_requests`
--

CREATE TABLE `withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` float(15,2) DEFAULT NULL,
  `service_charge` float(15,2) DEFAULT NULL,
  `payable_amount` float(15,2) DEFAULT NULL,
  `gateway` varchar(255) DEFAULT NULL,
  `request_to` varchar(255) DEFAULT NULL,
  `stockiest_id` int(191) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `bank_branch` varchar(255) DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `routing_number` varchar(255) DEFAULT NULL,
  `swift_code` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `paid_by` varchar(191) DEFAULT NULL,
  `user_type` varchar(191) NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `withdraw_requests`
--

INSERT INTO `withdraw_requests` (`id`, `user_id`, `amount`, `service_charge`, `payable_amount`, `gateway`, `request_to`, `stockiest_id`, `bank_name`, `bank_branch`, `account_name`, `account_number`, `routing_number`, `swift_code`, `status`, `note`, `paid_by`, `user_type`, `created_at`, `updated_at`) VALUES
(1, 121, 10.00, 0.00, 0.00, 'bkash', 'admin', NULL, NULL, NULL, 'Sonet', '01732379393', NULL, NULL, 'paid', 'Paid by 01914532589', NULL, 'user', '2024-08-28 08:14:14', '2024-08-28 10:20:20'),
(2, 121, 10.00, 0.00, 0.00, 'dbbl', 'stockiest', 1, 'DBBL', 'Mirpur-15', 'Shawn Shikder', '20254789632541', '456987', 'DBBLM', 'paid', 'Payed by Account: 01732379393', 'stockist-itrsp-0001', 'user', '2024-08-28 09:26:11', '2024-09-04 08:37:29'),
(3, 121, 10.00, 0.05, 9.95, 'bkash', 'stockiest', 2, NULL, NULL, 'Shawn', '01732379395', NULL, NULL, 'pending', NULL, NULL, 'user', '2024-09-05 04:43:32', '2024-09-05 04:43:32'),
(4, 121, 200.00, 10.00, 190.00, 'bkash', 'stockiest', 1, NULL, NULL, NULL, '01732379393', NULL, NULL, 'paid', 'TXN: ABVRT24OP8', 'stockist-itrsp-0001', 'user', '2024-09-09 07:51:53', '2024-09-09 10:20:43'),
(5, 1, 110.00, 3.30, 106.70, 'bkash', 'admin', NULL, NULL, NULL, NULL, '01732379393', NULL, NULL, 'pending', NULL, NULL, 'stockiest', '2024-09-09 11:41:29', '2024-09-09 11:41:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accounts_business_id_index` (`business_id`),
  ADD KEY `accounts_account_type_id_index` (`account_type_id`),
  ADD KEY `accounts_created_by_index` (`created_by`);

--
-- Indexes for table `account_transactions`
--
ALTER TABLE `account_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_transactions_account_id_index` (`account_id`),
  ADD KEY `account_transactions_transaction_id_index` (`transaction_id`),
  ADD KEY `account_transactions_transaction_payment_id_index` (`transaction_payment_id`),
  ADD KEY `account_transactions_transfer_transaction_id_index` (`transfer_transaction_id`),
  ADD KEY `account_transactions_created_by_index` (`created_by`),
  ADD KEY `account_transactions_type_index` (`type`),
  ADD KEY `account_transactions_sub_type_index` (`sub_type`),
  ADD KEY `account_transactions_operation_date_index` (`operation_date`);

--
-- Indexes for table `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_types_parent_account_type_id_index` (`parent_account_type_id`),
  ADD KEY `account_types_business_id_index` (`business_id`);

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD KEY `users_business_id_foreign` (`business_id`),
  ADD KEY `users_user_type_index` (`user_type`),
  ADD KEY `users_crm_contact_id_foreign` (`crm_contact_id`);

--
-- Indexes for table `balance_sheets`
--
ALTER TABLE `balance_sheets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `balance_transactions`
--
ALTER TABLE `balance_transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `balance_transactions_transaction_id_unique` (`transaction_id`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barcodes_business_id_foreign` (`business_id`);

--
-- Indexes for table `bonuses`
--
ALTER TABLE `bonuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bonus_info`
--
ALTER TABLE `bonus_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bonus_reports`
--
ALTER TABLE `bonus_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_contact_id_foreign` (`contact_id`),
  ADD KEY `bookings_business_id_foreign` (`business_id`),
  ADD KEY `bookings_created_by_foreign` (`created_by`),
  ADD KEY `bookings_table_id_index` (`table_id`),
  ADD KEY `bookings_waiter_id_index` (`waiter_id`),
  ADD KEY `bookings_location_id_index` (`location_id`),
  ADD KEY `bookings_booking_status_index` (`booking_status`),
  ADD KEY `bookings_correspondent_id_index` (`correspondent_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brands_business_id_foreign` (`business_id`),
  ADD KEY `brands_created_by_foreign` (`created_by`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_owner_id_foreign` (`owner_id`),
  ADD KEY `business_currency_id_foreign` (`currency_id`),
  ADD KEY `business_default_sales_tax_foreign` (`default_sales_tax`);

--
-- Indexes for table `business_locations`
--
ALTER TABLE `business_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_locations_business_id_index` (`business_id`),
  ADD KEY `business_locations_invoice_scheme_id_foreign` (`invoice_scheme_id`),
  ADD KEY `business_locations_invoice_layout_id_foreign` (`invoice_layout_id`),
  ADD KEY `business_locations_sale_invoice_layout_id_index` (`sale_invoice_layout_id`),
  ADD KEY `business_locations_selling_price_group_id_index` (`selling_price_group_id`),
  ADD KEY `business_locations_receipt_printer_type_index` (`receipt_printer_type`),
  ADD KEY `business_locations_printer_id_index` (`printer_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cache_key_unique` (`key`);

--
-- Indexes for table `captainship_bonuses`
--
ALTER TABLE `captainship_bonuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `captainship_bonuses_c_user_id_foreign` (`user_id`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_denominations`
--
ALTER TABLE `cash_denominations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_denominations_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_registers_business_id_foreign` (`business_id`),
  ADD KEY `cash_registers_user_id_foreign` (`user_id`),
  ADD KEY `cash_registers_location_id_index` (`location_id`);

--
-- Indexes for table `cash_register_transactions`
--
ALTER TABLE `cash_register_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_register_transactions_cash_register_id_foreign` (`cash_register_id`),
  ADD KEY `cash_register_transactions_transaction_id_index` (`transaction_id`),
  ADD KEY `cash_register_transactions_type_index` (`type`),
  ADD KEY `cash_register_transactions_transaction_type_index` (`transaction_type`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_business_id_foreign` (`business_id`),
  ADD KEY `categories_created_by_foreign` (`created_by`),
  ADD KEY `categories_parent_id_index` (`parent_id`);

--
-- Indexes for table `categorizables`
--
ALTER TABLE `categorizables`
  ADD KEY `categorizables_categorizable_type_categorizable_id_index` (`categorizable_type`,`categorizable_id`);

--
-- Indexes for table `cb_distribute_lists`
--
ALTER TABLE `cb_distribute_lists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_business_id_foreign` (`business_id`),
  ADD KEY `contacts_created_by_foreign` (`created_by`),
  ADD KEY `contacts_type_index` (`type`),
  ADD KEY `contacts_contact_status_index` (`contact_status`);

--
-- Indexes for table `contacts1`
--
ALTER TABLE `contacts1`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_business_id_foreign` (`business_id`),
  ADD KEY `contacts_created_by_foreign` (`created_by`),
  ADD KEY `contacts_type_index` (`type`),
  ADD KEY `contacts_contact_status_index` (`contact_status`);

--
-- Indexes for table `contacts2`
--
ALTER TABLE `contacts2`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_business_id_foreign` (`business_id`),
  ADD KEY `contacts_created_by_foreign` (`created_by`),
  ADD KEY `contacts_type_index` (`type`),
  ADD KEY `contacts_contact_status_index` (`contact_status`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_groups_business_id_foreign` (`business_id`),
  ADD KEY `customer_groups_created_by_index` (`created_by`),
  ADD KEY `customer_groups_price_calculation_type_index` (`price_calculation_type`),
  ADD KEY `customer_groups_selling_price_group_id_index` (`selling_price_group_id`);

--
-- Indexes for table `custom_users`
--
ALTER TABLE `custom_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `custom_users_referrer_id_foreign` (`referrer_id`);

--
-- Indexes for table `dashboard_configurations`
--
ALTER TABLE `dashboard_configurations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dashboard_configurations_business_id_foreign` (`business_id`);

--
-- Indexes for table `depos`
--
ALTER TABLE `depos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `depos_depo_user_id_unique` (`depo_user_id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discounts_business_id_index` (`business_id`),
  ADD KEY `discounts_brand_id_index` (`brand_id`),
  ADD KEY `discounts_category_id_index` (`category_id`),
  ADD KEY `discounts_location_id_index` (`location_id`),
  ADD KEY `discounts_priority_index` (`priority`),
  ADD KEY `discounts_spg_index` (`spg`);

--
-- Indexes for table `discount_variations`
--
ALTER TABLE `discount_variations`
  ADD KEY `discount_variations_discount_id_index` (`discount_id`),
  ADD KEY `discount_variations_variation_id_index` (`variation_id`);

--
-- Indexes for table `document_and_notes`
--
ALTER TABLE `document_and_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_and_notes_business_id_index` (`business_id`),
  ADD KEY `document_and_notes_notable_id_index` (`notable_id`),
  ADD KEY `document_and_notes_created_by_index` (`created_by`);

--
-- Indexes for table `equal_bonuses`
--
ALTER TABLE `equal_bonuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `equal_bonuses_c_user_id_foreign` (`user_id`);

--
-- Indexes for table `equel_bonus_user_to_places`
--
ALTER TABLE `equel_bonus_user_to_places`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expense_categories_business_id_foreign` (`business_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gardianship_bonuses`
--
ALTER TABLE `gardianship_bonuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gardianship_bonuses_c_user_id_foreign` (`c_user_id`);

--
-- Indexes for table `group_sub_taxes`
--
ALTER TABLE `group_sub_taxes`
  ADD KEY `group_sub_taxes_group_tax_id_foreign` (`group_tax_id`),
  ADD KEY `group_sub_taxes_tax_id_foreign` (`tax_id`);

--
-- Indexes for table `gs_distribute_lists`
--
ALTER TABLE `gs_distribute_lists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guardianship_bonuses`
--
ALTER TABLE `guardianship_bonuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_layouts`
--
ALTER TABLE `invoice_layouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_layouts_business_id_foreign` (`business_id`);

--
-- Indexes for table `invoice_schemes`
--
ALTER TABLE `invoice_schemes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_schemes_business_id_foreign` (`business_id`),
  ADD KEY `invoice_schemes_scheme_type_index` (`scheme_type`);

--
-- Indexes for table `ip_active`
--
ALTER TABLE `ip_active`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_business_id_index` (`business_id`),
  ADD KEY `media_uploaded_by_index` (`uploaded_by`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mlm_volumes`
--
ALTER TABLE `mlm_volumes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `order_invoice`
--
ALTER TABLE `order_invoice`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oreders_table`
--
ALTER TABLE `oreders_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_gateways_c_user_id_foreign` (`c_user_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `printers`
--
ALTER TABLE `printers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `printers_business_id_foreign` (`business_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `products_tax_foreign` (`tax`),
  ADD KEY `products_name_index` (`name`),
  ADD KEY `products_business_id_index` (`business_id`),
  ADD KEY `products_unit_id_index` (`unit_id`),
  ADD KEY `products_created_by_index` (`created_by`),
  ADD KEY `products_warranty_id_index` (`warranty_id`),
  ADD KEY `products_type_index` (`type`),
  ADD KEY `products_tax_type_index` (`tax_type`),
  ADD KEY `products_barcode_type_index` (`barcode_type`),
  ADD KEY `products_secondary_unit_id_index` (`secondary_unit_id`);

--
-- Indexes for table `product_locations`
--
ALTER TABLE `product_locations`
  ADD KEY `product_locations_product_id_index` (`product_id`),
  ADD KEY `product_locations_location_id_index` (`location_id`);

--
-- Indexes for table `product_racks`
--
ALTER TABLE `product_racks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_racks_business_id_index` (`business_id`),
  ADD KEY `product_racks_location_id_index` (`location_id`),
  ADD KEY `product_racks_product_id_index` (`product_id`);

--
-- Indexes for table `product_variations`
--
ALTER TABLE `product_variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variations_name_index` (`name`),
  ADD KEY `product_variations_product_id_index` (`product_id`);

--
-- Indexes for table `purchase_lines`
--
ALTER TABLE `purchase_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_lines_transaction_id_foreign` (`transaction_id`),
  ADD KEY `purchase_lines_product_id_foreign` (`product_id`),
  ADD KEY `purchase_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `purchase_lines_tax_id_foreign` (`tax_id`),
  ADD KEY `purchase_lines_sub_unit_id_index` (`sub_unit_id`),
  ADD KEY `purchase_lines_lot_number_index` (`lot_number`);

--
-- Indexes for table `redeem__beneficiaries`
--
ALTER TABLE `redeem__beneficiaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `redeem__beneficiaries_rp_redeemed_id_foreign` (`rp_redeemed_id`);

--
-- Indexes for table `reference_counts`
--
ALTER TABLE `reference_counts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reference_counts_business_id_index` (`business_id`);

--
-- Indexes for table `referrals`
--
ALTER TABLE `referrals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `referrals_user_id_foreign` (`user_id`),
  ADD KEY `referrals_referred_id_foreign` (`referred_id`);

--
-- Indexes for table `refer_percent`
--
ALTER TABLE `refer_percent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `res_product_modifier_sets`
--
ALTER TABLE `res_product_modifier_sets`
  ADD KEY `res_product_modifier_sets_modifier_set_id_foreign` (`modifier_set_id`);

--
-- Indexes for table `res_tables`
--
ALTER TABLE `res_tables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `res_tables_business_id_foreign` (`business_id`);

--
-- Indexes for table `re_purchase`
--
ALTER TABLE `re_purchase`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_business_id_foreign` (`business_id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `rp_redeemed_c_users`
--
ALTER TABLE `rp_redeemed_c_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rp_redeemed_c_users_c_user_id_foreign` (`c_user_id`),
  ADD KEY `rp_redeemed_c_users_transaction_id_foreign` (`transaction_id`);

--
-- Indexes for table `selling_price_groups`
--
ALTER TABLE `selling_price_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `selling_price_groups_business_id_foreign` (`business_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD UNIQUE KEY `sessions_id_unique` (`id`);

--
-- Indexes for table `stockiests`
--
ALTER TABLE `stockiests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stockiest_withdraw_balances`
--
ALTER TABLE `stockiest_withdraw_balances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_adjustment_lines`
--
ALTER TABLE `stock_adjustment_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_adjustment_lines_product_id_foreign` (`product_id`),
  ADD KEY `stock_adjustment_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `stock_adjustment_lines_transaction_id_index` (`transaction_id`),
  ADD KEY `stock_adjustment_lines_lot_no_line_id_index` (`lot_no_line_id`);

--
-- Indexes for table `system`
--
ALTER TABLE `system`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tax_rates_business_id_foreign` (`business_id`),
  ADD KEY `tax_rates_created_by_foreign` (`created_by`);

--
-- Indexes for table `total_bonus_points`
--
ALTER TABLE `total_bonus_points`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_tax_id_foreign` (`tax_id`),
  ADD KEY `transactions_business_id_index` (`business_id`),
  ADD KEY `transactions_type_index` (`type`),
  ADD KEY `transactions_contact_id_index` (`contact_id`),
  ADD KEY `transactions_transaction_date_index` (`transaction_date`),
  ADD KEY `transactions_created_by_index` (`created_by`),
  ADD KEY `transactions_location_id_index` (`location_id`),
  ADD KEY `transactions_expense_for_foreign` (`expense_for`),
  ADD KEY `transactions_expense_category_id_index` (`expense_category_id`),
  ADD KEY `transactions_sub_type_index` (`sub_type`),
  ADD KEY `transactions_return_parent_id_index` (`return_parent_id`),
  ADD KEY `type` (`type`),
  ADD KEY `transactions_status_index` (`status`),
  ADD KEY `transactions_sub_status_index` (`sub_status`),
  ADD KEY `transactions_res_table_id_index` (`res_table_id`),
  ADD KEY `transactions_res_waiter_id_index` (`res_waiter_id`),
  ADD KEY `transactions_res_order_status_index` (`res_order_status`),
  ADD KEY `transactions_payment_status_index` (`payment_status`),
  ADD KEY `transactions_discount_type_index` (`discount_type`),
  ADD KEY `transactions_commission_agent_index` (`commission_agent`),
  ADD KEY `transactions_transfer_parent_id_index` (`transfer_parent_id`),
  ADD KEY `transactions_types_of_service_id_index` (`types_of_service_id`),
  ADD KEY `transactions_packing_charge_type_index` (`packing_charge_type`),
  ADD KEY `transactions_recur_parent_id_index` (`recur_parent_id`),
  ADD KEY `transactions_selling_price_group_id_index` (`selling_price_group_id`),
  ADD KEY `transactions_delivery_date_index` (`delivery_date`);

--
-- Indexes for table `transaction_payments`
--
ALTER TABLE `transaction_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_payments_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_payments_created_by_index` (`created_by`),
  ADD KEY `transaction_payments_parent_id_index` (`parent_id`),
  ADD KEY `transaction_payments_payment_type_index` (`payment_type`);

--
-- Indexes for table `transaction_sell_lines`
--
ALTER TABLE `transaction_sell_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_sell_lines_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_sell_lines_product_id_foreign` (`product_id`),
  ADD KEY `transaction_sell_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `transaction_sell_lines_tax_id_foreign` (`tax_id`),
  ADD KEY `transaction_sell_lines_children_type_index` (`children_type`),
  ADD KEY `transaction_sell_lines_parent_sell_line_id_index` (`parent_sell_line_id`),
  ADD KEY `transaction_sell_lines_line_discount_type_index` (`line_discount_type`),
  ADD KEY `transaction_sell_lines_discount_id_index` (`discount_id`),
  ADD KEY `transaction_sell_lines_lot_no_line_id_index` (`lot_no_line_id`),
  ADD KEY `transaction_sell_lines_sub_unit_id_index` (`sub_unit_id`);

--
-- Indexes for table `transaction_sell_lines_purchase_lines`
--
ALTER TABLE `transaction_sell_lines_purchase_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sell_line_id` (`sell_line_id`),
  ADD KEY `stock_adjustment_line_id` (`stock_adjustment_line_id`),
  ADD KEY `purchase_line_id` (`purchase_line_id`);

--
-- Indexes for table `types_of_services`
--
ALTER TABLE `types_of_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `types_of_services_business_id_index` (`business_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `units_business_id_foreign` (`business_id`),
  ADD KEY `units_created_by_foreign` (`created_by`),
  ADD KEY `units_base_unit_id_index` (`base_unit_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD KEY `users_business_id_foreign` (`business_id`),
  ADD KEY `users_user_type_index` (`user_type`),
  ADD KEY `users_crm_contact_id_foreign` (`crm_contact_id`);

--
-- Indexes for table `user_contact_access`
--
ALTER TABLE `user_contact_access`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_contact_access_user_id_index` (`user_id`),
  ADD KEY `user_contact_access_contact_id_index` (`contact_id`);

--
-- Indexes for table `variations`
--
ALTER TABLE `variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variations_product_id_foreign` (`product_id`),
  ADD KEY `variations_product_variation_id_foreign` (`product_variation_id`),
  ADD KEY `variations_name_index` (`name`),
  ADD KEY `variations_sub_sku_index` (`sub_sku`),
  ADD KEY `variations_variation_value_id_index` (`variation_value_id`);

--
-- Indexes for table `variation_group_prices`
--
ALTER TABLE `variation_group_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_group_prices_variation_id_foreign` (`variation_id`),
  ADD KEY `variation_group_prices_price_group_id_foreign` (`price_group_id`);

--
-- Indexes for table `variation_location_details`
--
ALTER TABLE `variation_location_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_location_details_location_id_foreign` (`location_id`),
  ADD KEY `variation_location_details_product_id_index` (`product_id`),
  ADD KEY `variation_location_details_product_variation_id_index` (`product_variation_id`),
  ADD KEY `variation_location_details_variation_id_index` (`variation_id`);

--
-- Indexes for table `variation_templates`
--
ALTER TABLE `variation_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_templates_business_id_foreign` (`business_id`);

--
-- Indexes for table `variation_value_templates`
--
ALTER TABLE `variation_value_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_value_templates_name_index` (`name`),
  ADD KEY `variation_value_templates_variation_template_id_index` (`variation_template_id`);

--
-- Indexes for table `warranties`
--
ALTER TABLE `warranties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warranties_business_id_index` (`business_id`),
  ADD KEY `warranties_duration_type_index` (`duration_type`);

--
-- Indexes for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_transactions`
--
ALTER TABLE `account_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_types`
--
ALTER TABLE `account_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `balance_sheets`
--
ALTER TABLE `balance_sheets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `balance_transactions`
--
ALTER TABLE `balance_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `bonuses`
--
ALTER TABLE `bonuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bonus_info`
--
ALTER TABLE `bonus_info`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bonus_reports`
--
ALTER TABLE `bonus_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `business_locations`
--
ALTER TABLE `business_locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cache`
--
ALTER TABLE `cache`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `captainship_bonuses`
--
ALTER TABLE `captainship_bonuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=511;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `cash_denominations`
--
ALTER TABLE `cash_denominations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cash_register_transactions`
--
ALTER TABLE `cash_register_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cb_distribute_lists`
--
ALTER TABLE `cb_distribute_lists`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `contacts1`
--
ALTER TABLE `contacts1`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `contacts2`
--
ALTER TABLE `contacts2`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_users`
--
ALTER TABLE `custom_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=310;

--
-- AUTO_INCREMENT for table `dashboard_configurations`
--
ALTER TABLE `dashboard_configurations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `depos`
--
ALTER TABLE `depos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_and_notes`
--
ALTER TABLE `document_and_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `equal_bonuses`
--
ALTER TABLE `equal_bonuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `equel_bonus_user_to_places`
--
ALTER TABLE `equel_bonus_user_to_places`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gardianship_bonuses`
--
ALTER TABLE `gardianship_bonuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gs_distribute_lists`
--
ALTER TABLE `gs_distribute_lists`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `guardianship_bonuses`
--
ALTER TABLE `guardianship_bonuses`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- AUTO_INCREMENT for table `invoice_layouts`
--
ALTER TABLE `invoice_layouts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoice_schemes`
--
ALTER TABLE `invoice_schemes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ip_active`
--
ALTER TABLE `ip_active`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=294;

--
-- AUTO_INCREMENT for table `mlm_volumes`
--
ALTER TABLE `mlm_volumes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_invoice`
--
ALTER TABLE `order_invoice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oreders_table`
--
ALTER TABLE `oreders_table`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `printers`
--
ALTER TABLE `printers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=596;

--
-- AUTO_INCREMENT for table `product_racks`
--
ALTER TABLE `product_racks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variations`
--
ALTER TABLE `product_variations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=366;

--
-- AUTO_INCREMENT for table `purchase_lines`
--
ALTER TABLE `purchase_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT for table `redeem__beneficiaries`
--
ALTER TABLE `redeem__beneficiaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=972;

--
-- AUTO_INCREMENT for table `reference_counts`
--
ALTER TABLE `reference_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `referrals`
--
ALTER TABLE `referrals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

--
-- AUTO_INCREMENT for table `refer_percent`
--
ALTER TABLE `refer_percent`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `res_tables`
--
ALTER TABLE `res_tables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `re_purchase`
--
ALTER TABLE `re_purchase`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rp_redeemed_c_users`
--
ALTER TABLE `rp_redeemed_c_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

--
-- AUTO_INCREMENT for table `selling_price_groups`
--
ALTER TABLE `selling_price_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stockiests`
--
ALTER TABLE `stockiests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `stockiest_withdraw_balances`
--
ALTER TABLE `stockiest_withdraw_balances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `stock_adjustment_lines`
--
ALTER TABLE `stock_adjustment_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system`
--
ALTER TABLE `system`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tax_rates`
--
ALTER TABLE `tax_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `total_bonus_points`
--
ALTER TABLE `total_bonus_points`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `transaction_payments`
--
ALTER TABLE `transaction_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_sell_lines`
--
ALTER TABLE `transaction_sell_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_sell_lines_purchase_lines`
--
ALTER TABLE `transaction_sell_lines_purchase_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `types_of_services`
--
ALTER TABLE `types_of_services`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_contact_access`
--
ALTER TABLE `user_contact_access`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `variations`
--
ALTER TABLE `variations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=366;

--
-- AUTO_INCREMENT for table `variation_group_prices`
--
ALTER TABLE `variation_group_prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `variation_location_details`
--
ALTER TABLE `variation_location_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `variation_templates`
--
ALTER TABLE `variation_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `variation_value_templates`
--
ALTER TABLE `variation_value_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warranties`
--
ALTER TABLE `warranties`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD CONSTRAINT `users_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_crm_contact_id_foreign` FOREIGN KEY (`crm_contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD CONSTRAINT `barcodes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts1` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `brands`
--
ALTER TABLE `brands`
  ADD CONSTRAINT `brands_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `brands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `business`
--
ALTER TABLE `business`
  ADD CONSTRAINT `business_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  ADD CONSTRAINT `business_default_sales_tax_foreign` FOREIGN KEY (`default_sales_tax`) REFERENCES `tax_rates` (`id`),
  ADD CONSTRAINT `business_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `business_locations`
--
ALTER TABLE `business_locations`
  ADD CONSTRAINT `business_locations_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `business_locations_invoice_layout_id_foreign` FOREIGN KEY (`invoice_layout_id`) REFERENCES `invoice_layouts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `business_locations_invoice_scheme_id_foreign` FOREIGN KEY (`invoice_scheme_id`) REFERENCES `invoice_schemes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD CONSTRAINT `cash_registers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cash_registers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
