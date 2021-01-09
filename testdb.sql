-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Янв 09 2021 г., 11:59
-- Версия сервера: 8.0.22
-- Версия PHP: 7.2.24-0ubuntu0.18.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `testdb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20210107195134', '2021-01-07 22:51:54', 286),
('DoctrineMigrations\\Version20210108183826', '2021-01-08 21:38:51', 128);

-- --------------------------------------------------------

--
-- Структура таблицы `order`
--

CREATE TABLE `order` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `create_time` datetime NOT NULL,
  `products` json NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `id` int NOT NULL,
  `vendor_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `quantity` smallint DEFAULT NULL,
  `thumbnail` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`id`, `vendor_code`, `price`, `title`, `url`, `description`, `quantity`, `thumbnail`) VALUES
(1, '4456', 158000, 'Торт Синнокейк с корицей', 'tort-sinnokeik-s-koritsei', 'Между воздушных бисквитов с орехами пекан две прослойки из нежного крема с корицей и карамелью. Сверху полит толстым слоем карамели с корицей и украшен горстью орехов пекан. \r\n<br>\r\n<br>\r\nСтрана производства: Россия\r\n \r\n<br>\r\n<br>\r\nСрок годности: двенадцать (12) месяцев с даты изготовления, при температуре минус 18°С. Дата изготовления указана на упаковке (число, месяц год)\r\n \r\n<br>\r\n<br>\r\nСпособ разморозки: замороженный продукт разморозить при температуре +2°С/+5°С в течение 1-2 часов до полной разморозки.', 12, 'tort-sinnokejk-s-koricej-0.jpg'),
(2, '6674', 9000, 'Торт брусничный с белым шоколадом (1п.)', 'tort-brusnichnii-s-belim-shokoladom-1p', 'Страна производства: Россия\r\n \r\n<br>\r\n<br>\r\nСрок годности: двенадцать (12) месяцев с даты изготовления при температуре минус 18°С. Размороженный продукт хранить при температуре +2°С/+5°С не более 48 ч.\r\n \r\n<br>\r\n<br>\r\nСпособ разморозки: замороженный продукт разморозить при температуре +2°С/+5°С в течение 1-2 часов до полной разморозки. Размороженный продукт повторно не замораживать!', 0, 'tort-brusnichnyj-s-belym-shokoladom-kopiya-3-1.jpg'),
(3, '8886', 150000, 'Торт «Рикотта с грушей»', 'tort-rikotta-s-grushei', 'Страна производства: Италия\r\n \r\n<br>\r\n<br>\r\nСрок годности: 24 мес. при температуре минус 18°С (в морозильнике); после разморозки 3 дня (в холодильнике)\r\n \r\n<br>\r\n<br>\r\nСпособ разморозки: В холодильнике – 4 часа, 1 кусок в холодильнике в течение 1 часа. Подается холодным.', 4, 'tort-rikotta-s-grushej-2-0.jpg'),
(4, '8423', 173000, 'Торт \"Малиновая панна котта\"', 'tort-malinovaya-panna-kotta', 'Страна производства: Россия\r\n \r\n<br>\r\n<br>\r\nСрок годности: 12 месяцев с даты изготовления, при температуре минус 18°С. Дата изготовления указана на упаковке (число, месяц год)', 7, 'tort-malinovaya-panna-kotta-2-1.jpg'),
(5, '2234', 159000, 'Торт Груша и шоколад', 'tort-grusha-i-shokolad', 'Страна производства: Италия\r\n \r\n<br>\r\n<br>\r\nСрок годности: 24 мес. при t – 18°С (в морозильнике); после разморозки – 2 дня (в холодильнике)\r\n \r\n<br>\r\n<br>\r\nСпособ разморозки: 1 порция: 30-60 мин. при комнатной температуре. Подается холодным.', 12, 'tort-pere-e-cioccolato-0.jpg'),
(6, '8894', 94000, 'Торт Кассата с марципаном', 'tort-kassata-s-martsipanom', 'Между двумя тонкими слоями бисквита расположен толстый слой начинки на основе сыра Рикотта. Сверху торт залит марципаном и украшен цукатами из апельсина и вишней в сиропе\r\n \r\n<br>\r\n<br>\r\nCтрана производства: Россия\r\n \r\n<br>\r\n<br>\r\nСрок годности: 12 мес. при температуре минус 18°С (в морозильнике); после разморозки – не более 48 ч (в холодильнике, при температуре +4°С)\r\n \r\n<br>\r\n<br>\r\nСпособ разморозки: замороженное пирожное разморозить при  температуре +4°С (+/-2°С) в течение 1-2 ч.', 11, 'tort-brusnichno-kremovyj-s-belym-shokoladom-3-2-0.jpg'),
(7, '0975', 97000, 'Торт \"Ванильно-карамельный\"', 'tort-vanilno-karamelnii', 'Страна производства: Россия\r\n \r\n<br>\r\n<br>\r\nСрок годности: 12 месяцев с даты изготовления при температуре минус 18°С. Размороженный продукт хранить при температуре +2°С/+5°С не более 48 ч.\r\n \r\n<br>\r\n<br>\r\nСпособ разморозки: замороженный продукт разморозить при температуре +2°С/+5°С в течение 1-2 часов до полной разморозки. Размороженный продукт повторно не замораживать!', 5, 'tort-vanilno-karamelnyjcp-0.jpg'),
(8, '2299', 107000, 'Медовик', 'medovik', 'Страна производства: Россия\r\n \r\n<br>\r\n<br>\r\nСрок годности: 12 мес. при температуре  от -30°С до−18°С ( в морозильнике); после разморозки – в холодильнике при температуре +4°С (+/-2°С) 120 ч; при комнатной температуре +20/+25°С - 24 ч.\r\n \r\n<br>\r\n<br>\r\nСпособ разморозки: кусок размораживать при комнатной температуре +20/+25°С -15-25 мин., целый  торт при температуре +4°С (+/-2°С) -  6-10 ч.\r\n \r\n<br>\r\n<br>\r\nПродукт повторно не замораживать!', 8, 'medovik-0.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `name`, `address`) VALUES
(1, 'testuser@testhost.ru', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$BLwYbzDN2qWl0hzVXM6Hpg$m9RptJ3eEXvjMg5Y9PSEMu0gfYiht1aNvw182Rys79c', 'Test User', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Индексы таблицы `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F5299398A76ED395` (`user_id`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_D34A04AD5DD83547` (`vendor_code`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `order`
--
ALTER TABLE `order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
