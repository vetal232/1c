﻿
#Область ПрограммныйИнтерфейс

&НаСервере
Процедура ЗаполнитьВидыДокументов() Экспорт
	
	ТаблицаДокументов = Новый ТаблицаЗначений;
	ТаблицаДокументов.Колонки.Добавить("Имя"			, Новый ОписаниеТипов("Строка", Новый КвалификаторыСтроки(100)));
	ТаблицаДокументов.Колонки.Добавить("Представление"	, Новый ОписаниеТипов("Строка", Новый КвалификаторыСтроки(150)));
	ТаблицаДокументов.Колонки.Добавить("Направление"	, Новый ОписаниеТипов("Строка", Новый КвалификаторыСтроки(100)));
	
	Макет = ЭтотОбъект.ПолучитьМакет("ДоступныеДокументы");
	Для СчетчикСтрок = 2 По 100 Цикл
		
		ИмяДокумента = Макет.Область("R" + СчетчикСтрок + "C" + 1).Текст;
		Если ПустаяСтрока(ИмяДокумента) Тогда
			Прервать;
		КонецЕсли;
		
		СтрокаДокумента 				= ТаблицаДокументов.Добавить();
		СтрокаДокумента.Имя 			= ИмяДокумента;
		СтрокаДокумента.Представление 	= Макет.Область("R" + СчетчикСтрок + "C" + ?(эдиОбработкаДляСети, 3, 2)).Текст;
		СтрокаДокумента.Направление 	= Макет.Область("R" + СчетчикСтрок + "C" + ?(эдиОбработкаДляСети, 5, 4)).Текст; 
		
	КонецЦикла;

	МассивУдаляемыхЭлементов = Новый Массив;
	Для Каждого ЭлементСписка Из эдиСписокВходящих Цикл
		
		Если ТаблицаДокументов.Найти(ЭлементСписка.Значение, "Имя") = Неопределено Тогда
			МассивУдаляемыхЭлементов.Добавить(ЭлементСписка);
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого ЭлементСписка Из МассивУдаляемыхЭлементов Цикл
		эдиСписокВходящих.Удалить(ЭлементСписка);
	КонецЦикла;
	
	Для Каждого СтрокаТаблицы Из ТаблицаДокументов Цикл
		
		Если эдиСписокВходящих.НайтиПоЗначению(СтрокаТаблицы.Имя) = Неопределено Тогда
			эдиСписокВходящих.Добавить(СтрокаТаблицы.Имя, СтрокаТаблицы.Представление, ?(СтрокаТаблицы.Направление = "D", Истина, Ложь));
		КонецЕсли;
		
	КонецЦикла;
	
	МассивУдаляемыхЭлементов.Очистить();
	Для Каждого ЭлементСписка Из эдиСписокИсходящих Цикл
		
		Если ТаблицаДокументов.Найти(ЭлементСписка.Значение, "Имя") = Неопределено Тогда
			МассивУдаляемыхЭлементов.Добавить(ЭлементСписка);
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого ЭлементСписка Из МассивУдаляемыхЭлементов Цикл
		эдиСписокИсходящих.Удалить(ЭлементСписка);
	КонецЦикла;
	
	Для Каждого СтрокаТаблицы Из ТаблицаДокументов Цикл
		
		Если эдиСписокИсходящих.НайтиПоЗначению(СтрокаТаблицы.Имя) = Неопределено Тогда
			эдиСписокИсходящих.Добавить(СтрокаТаблицы.Имя, СтрокаТаблицы.Представление, ?(СтрокаТаблицы.Направление = "U", Истина, Ложь));
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ВерсияМодуля() Экспорт
	
	Возврат 0;
	
КонецФункции

#КонецОбласти