﻿&НаКлиенте
Перем ЭДИ_ОбщиеИнструменты;
&НаКлиенте
Перем ЭДИ_РаботаСБазойДанных;
&НаКлиенте
Перем ПолучательБД_Подключен;

&НаКлиенте
Процедура ОткрытьВходящие(Команда)	
	СохранитьОрганизациюСервер(ПрофильНастроек);
	ФОрмаВходящие = ПолучитьФорму("ВнешняяОбработка.EDISOFT.Форма.ФормаВходящие");
	ФормаВходящие.Открыть();
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьИсходящие(Команда)
	СохранитьОрганизациюСервер(ПрофильНастроек);
	Объект.ИсходящиеОткрыта = Ложь;
	ФОрмаИсходящие = ПолучитьФорму("ВнешняяОбработка.EDISOFT.Форма.ФормаИсходящие");
	ФОрмаИсходящие.Открыть();
	Если Объект.ИсходящиеОткрыта Тогда
		ЭтаФорма.Закрыть();
	КонецЕсли;

	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНастройки(Команда)
	СохранитьОрганизациюСервер(ПрофильНастроек);
	ФормаНастроек = ПолучитьФорму("ВнешняяОбработка.EDISOFT.Форма.ФормаНастройки");
	ФормаНастроек.Открыть();
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ВосстановитьНастройкиПодключения();
	ПолучитьОбщиеИнструменты();
	
	Если НЕ ЭДИ_РаботаСБазойДанных = Неопределено Тогда
		ПолучитьПрофилиНастроек();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьОбщиеИнструменты()
	ЭДИ_ОбщиеИнструменты = Новый COMОбъект("EsTools1C.ExtTools");
	ПодключитьсяКБД();
КонецПроцедуры

&НаКлиенте
Функция ПроверитьСуществованиеКаталога(ИмяКаталога) Экспорт
    КаталогНаДиске = Новый Файл(ИмяКаталога);
    Если КаталогНаДиске.Существует() Тогда
        Возврат Истина;
    Иначе
		//Ответ = Вопрос("Каталог бызы данных не существует. Создать?", 
		//                РежимДиалогаВопрос.ОКОтмена);
		//Если Ответ = КодВозвратаДиалога.ОК Тогда
		//    СоздатьКаталог(ИмяКаталога);
		//    Возврат Истина;
		//Иначе
		    Возврат Ложь;
		//КонецЕсли;
    КонецЕсли;
КонецФункции

&НаКлиенте
Процедура ПодключитьсяКБД()
	ПолучательБД_Подключен=ложь;   
	ЭДИ_ПараметрSQLITE=0;
	Если ПроверитьСуществованиеКаталога(Объект.ЭДИ_КаталогВнешнейБазыДанных)=Ложь тогда
		Возврат;
	КонецЕсли;
	Если Объект.ЭДИ_РежимРаботыБД = "sqlite" тогда 
		ЭДИ_ПараметрSQLITE = 0;
		ЭДИ_СтрокаПодключения = СокрЛП(Объект.ЭДИ_КаталогВнешнейБазыДанных);
	ИначеЕсли Объект.ЭДИ_РежимРаботыБД = "MY" тогда 
		ЭДИ_СтрокаПодключения = "DRIVER={MySQL ODBC 5.3 ANSI Driver};Server="+СокрЛП(Объект.ЭДИ_СерверБД)+";Port="+СокрЛП(Объект.ЭДИ_ПортБД)+";Database="+СокрЛП(Объект.ЭДИ_КаталогВнешнейБазыДанных)+";User="+СокрЛП(Объект.ЭДИ_ПользовательБД)+";Password="+СокрЛП(Объект.ЭДИ_ПарольБД)+";";  //MySQL
	ИначеЕсли Объект.ЭДИ_РежимРаботыБД = "PG" тогда  
		ЭДИ_СтрокаПодключения = "DSN=PostgreSQL30;Server="+СокрЛП(Объект.ЭДИ_СерверБД)+";Port="+СокрЛП(Объект.ЭДИ_ПортБД)+";Database="+СокрЛП(Объект.ЭДИ_КаталогВнешнейБазыДанных)+";UID="+СокрЛП(Объект.ЭДИ_ПользовательБД)+";Pwd="+СокрЛП(Объект.ЭДИ_ПарольБД)+";";   //PostgreSQL
	иначеЕсли Объект.ЭДИ_РежимРаботыБД = "MSNC10" тогда  
		ЭДИ_СтрокаПодключения = "Driver={SQL Server Native Client 10.0};Server="+СокрЛП(Объект.ЭДИ_СерверБД)+";Database="+СокрЛП(Объект.ЭДИ_КаталогВнешнейБазыДанных)+";Uid="+СокрЛП(Объект.ЭДИ_ПользовательБД)+";Pwd="+СокрЛП(Объект.ЭДИ_ПарольБД)+";"
	иначеЕсли Объект.ЭДИ_РежимРаботыБД = "MSNC11" тогда  
		ЭДИ_СтрокаПодключения = "Driver={SQL Server Native Client 11.0};Server="+СокрЛП(Объект.ЭДИ_СерверБД)+";Database="+СокрЛП(Объект.ЭДИ_КаталогВнешнейБазыДанных)+";Uid="+СокрЛП(Объект.ЭДИ_ПользовательБД)+";Pwd="+СокрЛП(Объект.ЭДИ_ПарольБД)+";"
	иначеЕсли Объект.ЭДИ_РежимРаботыБД = "MSSSD" тогда  
		ЭДИ_СтрокаПодключения = "Driver={SQL Server};Server="+СокрЛП(Объект.ЭДИ_СерверБД)+";Database="+СокрЛП(Объект.ЭДИ_КаталогВнешнейБазыДанных)+";Uid="+СокрЛП(Объект.ЭДИ_ПользовательБД)+";Pwd="+СокрЛП(Объект.ЭДИ_ПарольБД)+";"
	КонецЕСлИ; 
	
	Если ЭДИ_СтрокаПодключения="" тогда
		Предупреждение("Нет настроек подключения к БД!");
		Возврат;
	КонецеСли;

	ИмяТаблицыПолучатель = СокрЛП(Объект.ЭДИ_ИмяТаблицы);
	
	Попытка
		ЭДИ_РаботаСБазойДанных = ЭДИ_ОбщиеИнструменты.ПолучитьВнешнююБазуДанных(ЭДИ_СтрокаПодключения, Объект.ЭДИ_РежимРаботыБД, ЭДИ_ПараметрSQLITE, ИмяТаблицыПолучатель);
		Если ЭДИ_РаботаСБазойДанных.ЕстьОшибка=1 тогда
			ПолучательБД_Подключен = Ложь;
			Сообщить("Ошибка подключение к базе данных по причине: " + ЭДИ_РаботаСБазойДанных.СообщениеОшибки + ". Проверьте параметры подключения на странице настройки.");
		иначе	
			ПолучательБД_Подключен = Истина;			
		КонецЕСЛИ;
	исключение
		ПолучательБД_Подключен = Ложь;
		Сообщить(Описаниеошибки());
	Конецпопытки;
КонецПроцедуры

Процедура ВосстановитьНастройкиПодключения()
	Объект.ЭДИ_ИмяТаблицы = ХранилищеОбщихНастроек.Загрузить("ОбъектЭДИ_ИмяТаблицы", "КлючЭДИ_ИмяТаблицы", "ЭДИ_ИмяТаблицы");
	Объект.ЭДИ_КаталогВнешнейБазыДанных = ХранилищеОбщихНастроек.Загрузить("ОбъектЭДИ_КаталогВнешнейБазыДанных", "КлючЭДИ_КаталогВнешнейБазыДанных", "ЭДИ_КаталогВнешнейБазыДанных");
	Объект.ЭДИ_ПарольБД = ХранилищеОбщихНастроек.Загрузить("ОбъектЭДИ_ПарольБД", "КлючЭДИ_ПарольБД", "ЭДИ_ПарольБД");
	Объект.ЭДИ_ПользовательБД = ХранилищеОбщихНастроек.Загрузить("ОбъектЭДИ_ПользовательБД", "КлючЭДИ_ПользовательБД", "ЭДИ_ПользовательБД");
	Объект.ЭДИ_ПортБД = ХранилищеОбщихНастроек.Загрузить("ОбъектЭДИ_ПортБД", "КлючЭДИ_ПортБД",  "ЭДИ_ПортБД");
	Объект.ЭДИ_РежимРаботыБД = ХранилищеОбщихНастроек.Загрузить("ОбъектЭДИ_РежимРаботыБД", "КлючЭДИ_РежимРаботыБД",  "ЭДИ_РежимРаботыБД");
	Объект.ЭДИ_СерверБД = ХранилищеОбщихНастроек.Загрузить("ОбъектЭДИ_СерверБД", "КлючЭДИ_СерверБД",  "ЭДИ_СерверБД");	
КонецПроцедуры


&НаКлиенте
Процедура ПолучитьПрофилиНастроек()	

	Пользователь = ПолучитьТекущегоПользователя();
	ПользовательСтрока = ЗначениеВСтрокуВнутрСервер(Пользователь);
	Сообщить("Получаем настройки для пользователя " + Пользователь);
	
	Отбор = ЭДИ_РаботаСБазойДанных.ПолучитьПустуюЗапись();	
	Отбор.Объект = ПользовательСтрока;			
	//Отбор.Владелец = ЗначениеВСтрокуВнутрСервер(Объект.Организация);
	Отбор.Тип = "SETTINGS";
	Запрос = ЭДИ_РаботаСБазойДанных.ПолучитьСписокСвойств(Отбор);
	Если Запрос.Результат=0 тогда
		Сообщить("Не удалось получить настройки для данного пользователя. Возможно, это первый случай использования данного модуля текущим пользователем. Ошибка 01");//нет записей по заданному отбору
		Возврат;
	Иначе
		
		СписокДанных = Запрос.Содержимое;
		Для Сч=0 По СписокДанных.Верхнийиндекс() Цикл
			Свойство = СписокДанных.Получить(Сч);
			Попытка
				Организация = ЗначениеИзСтрокиВнутрСервер(Свойство.Владелец);
				ЭтаФорма.Элементы.ПрофильНастроек.СписокВыбора.Добавить(Организация, Организация);
				//ВосстановитьНастройкиПриОткрытииСервер(Свойство.ДопАтрибуты);	
			Исключение
				СОобщить(ОписаниеОшибки());
			КонецПопытки;
			Продолжить
		КонецЦикла; 
		//Возврат (Сч);
	КонецЕсли;
	Организация = ПолучитьТекущуюОрганизацию();
	Если ЗначениеЗаполнено(Организация) Тогда
		ПрофильНастроек = Организация;	
	КонецЕсли;
КонецПроцедуры

Функция ПолучитьТекущуюОрганизацию()
	Попытка
		Возврат ХранилищеОбщихНастроек.Загрузить("ОбъектОрганизация", "КлючОрганизация","Организация");	
	Исключение
		Возврат Справочники.Организации.ПустаяСсылка();
	КонецПопытки;
КонецФункции


Функция ЗначениеИзСтрокиВнутрСервер(Строка)
	Возврат ЗначениеИзСтрокиВнутр(Строка);
КонецФункции

Функция ЗначениеВСтрокуВнутрСервер(Значение)
	Возврат ЗначениеВСтрокуВнутр(Значение);
КонецФункции

Функция ПолучитьТекущегоПользователя()
	Возврат ПараметрыСеанса.ТекущийПользователь;
КонецФункции

&НаКлиенте
Процедура ОткрытьМенеджерСторонОбмена(Команда)
	ФормаСторонОбмена = ПолучитьФорму("ВнешняяОбработка.EDISOFT.Форма.МенеджерСторонОбмена");
	ФормаСторонОбмена.ОткрытьМОдально();
КонецПроцедуры

&НаКлиенте
Процедура Версия(Команда)
	РаботаСБиблиотекой = Новый COMОбъект("EsTools1C.ExtTools");
	Сообщить(РаботаСБиблиотекой.Версия());
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьСвойстваНоменклатуры(Команда)
	ФормаСвойствНоменклатуры = ПолучитьФорму("ВнешняяОбработка.EDISOFT.Форма.СвойстваНоменклатуры");
	ФормаСвойствНоменклатуры.ОткрытьМодально();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьМенеджерБД(Команда)
	ФормаМенеджерБД = ПолучитьФорму("ВнешняяОбработка.EDISOFT.Форма.МенеджерВнешнейБазыДанных");
	ФормаМенеджерБД.Открыть();
	ЭтаФорма.Закрыть();
	// Вставить содержимое обработчика.
КонецПроцедуры
&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	//СохранитьОрганизациюСервер(ПрофильНастроек);
КонецПроцедуры

Функция СохранитьОрганизациюСервер(ОрганизацяДляНастроек)
	ХранилищеОбщихНастроек.Сохранить("ОбъектОрганизация", "КлючОрганизация", ОрганизацяДляНастроек,"Организация");		
КонецФункции	

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
КонецПроцедуры
