Функция getDocument() Экспорт
	Метод = "getDocument";
	ЗапросSOAP = "<soapenv:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:lin=""http://linkserver.ediweb.ru"">
	|   <soapenv:Header/>
	|   <soapenv:Body>
	|	  <lin:getDocument>
	|		 <documentId>58861</documentId>
	|	  </lin:getDocument>
	|   </soapenv:Body>
	|</soapenv:Envelope>";
	
	Возврат ОтправитьЗапросSOAP(Метод,ЗапросSOAP);
КонецФункции



Функция ОтправитьЗапросSOAP(Метод,ЗапросSOAP)
	Попытка
		xmlHttp = Новый COMОбъект("MSXML2.ServerXMLHTTP.6.0");//MSXML2.xmlHttp
		//xmlHttp.setTimeouts(10*1000, 10*1000, (ТаймаутВебСервиса)*1000, (ТаймаутВебСервиса)*1000);//resolveTimeout, connectTimeout, sendTimeout, receiveTimeout
		
		xmlHttp.setOption(2,13056);
		
		//Если ПроксиВключен = Истина Тогда
		//	xmlhttp.setProxy("2", ПроксиАдрес+?(ЗначениеЗаполнено(ПроксиПорт),":"+ПроксиПорт,""));    
		//КонецЕсли;  
		
		xmlHttp.OPEN("POST", "https://linkserver-demo.ediweb.com/linkserver/ws?wsdl", 0);
		
		//Если ПроксиЗащищенЛогиномИПаролем = Истина Тогда
		//	xmlhttp.setProxyCredentials(ПроксиЛогин, ПроксиПароль);
		//КонецЕсли; 
		
		//xmlHttp.setRequestHeader("SOAPAction", "urn:wsedi/"+Метод);
		xmlHttp.setRequestHeader("Authorization", "Basic " + Base64Строка(Новый ДвоичныеДанные("D:\Файл.xml")));
		xmlHttp.setRequestHeader("Host", "https://linkserver-demo.ediweb.com"); //"service.ediweb.ru"
		xmlHttp.setRequestHeader("Content-type", "text/xml");
		xmlHttp.SEND(ЗапросSOAP);
		СтрокаXML=xmlHttp.responseText;
	Исключение
		ВызватьИсключение(ОписаниеОшибки());
		//ВызватьИсключение(Э_ПредставлениеОшибки(ИнформацияОбОшибке()));
		//Возврат Неопределено;
	КонецПопытки;
	
	Если Не ЗначениеЗаполнено(СтрокаXML) Тогда
		ВызватьИсключение("MSXML2.ServerXMLHTTP ERROR: ("+xmlHttp.status+") "+xmlhttp.statustext);
	КонецЕсли; 
	
	ЧтениеXML = Новый ЧтениеXML;//добавить обработку варианта с входящей html
	ЧтениеXML.УстановитьСтроку(СтрокаXML);
	Фабрика = Новый ФабрикаXDTO;
	СтруктураXML = Фабрика.ПрочитатьXML(ЧтениеXML);
	Попытка Base64Ответ = СтруктураXML.Body.getDocumentResponse.document.content Исключение Base64Ответ = Неопределено; КонецПопытки; 
	
	Если НЕ ЗначениеЗаполнено(Base64Ответ) Тогда
		Сообщить("Пустой ответ");
	КонецЕсли;
	
	Попытка
					ДвоичныеДанные = Base64Значение(Base64Ответ);
				Исключение
					Сообщить(ОписаниеОшибки(),СтатусСообщения.Важное); //TaMaGo4u опять сообщение. исходный код отклонен
//					Сообщить(Э_ПредставлениеОшибки(ИнформацияОбОшибке()),СтатусСообщения.Важное);
					
				КонецПопытки;
				ДвоичныеДанные.Записать("D:\temp.txt");
				
				ЧтениеXML.ОткрытьФайл("D:\temp.txt");
				Попытка
					Корень = Фабрика.ПрочитатьXML(ЧтениеXML);
				Исключение
					Сообщить("Файл "+"D:\temp.txt"+" не является файлом XML");
				КонецПопытки; 
	
	Сообщить(Корень);
	
КонецФункции



Процедура КнопкаВыполнитьНажатие(Кнопка)
	
	getDocument();
	// Вставить содержимое обработчика.
	
	//СервисСОАП = Новый COMОбъект("MSSoap.SoapClient30");
	//        СервисСОАП.MSSoapInit("http://linkserver-demo.ediweb.com/linkserver/ws?wsdl");
	//        СервисСОАП.ConnectorProperty("AuthUser","soap-1c-test"); 
	//        СервисСОАП.ConnectorProperty("AuthPassword","soap-1c-test"); 
	//        СервисСОАП.ConnectorProperty("WinHTTPAuthScheme",1); 
	//        ОтветСервиса = СервисСОАП.getEdiDocument("58861"); 

	//
	
	
//	Определения = Новый WSОпределения("https://linkserver-demo.ediweb.com/linkserver/ws?wsdl","soap-1c-test","soap-1c-test");
//WSПрокси = Новый WSПрокси(Определения, "http://linkserver.ediweb.ru","LinkserverSoapApiService", "LinkserverSoapApiPort");

////Определения = WSСсылки.LinkDemo.ПолучитьWSОпределения();
//WSПрокси.Пользователь = "soap-1c-test"; 
//WSПрокси.Пароль = "soap-1c-test";
////WSПрокси.ТочкаПодключения.Местоположение =  "https://linkserver-demo.ediweb.com/linkserver/ws?wsdl";

//Фабрика = WSПрокси.ФабрикаXDTO; 
//Параметры = Фабрика.Создать(Фабрика.Тип("http://linkserver.ediweb.ru","findNewErpDocumentsWithLimit"));
//Параметры.gln = "2001000010000";
//Параметры.maxItems = 10;


// Пакет = Определения.ФабрикаXDTO.Пакеты.Получить("http://linkserver.ediweb.ru");
// СвойствоXDTO = Пакет.КорневыеСвойства.Получить("findNewErpDocumentsWithLimit");
//Параметры2 = Определения.ФабрикаXDTO.Создать(СвойствоXDTO.Тип);
//Параметры.gln = "2001000010000";
//Параметры.maxItems = 10;


//Параметры3 = Фабрика.Создать(Фабрика.Тип("http://linkserver.ediweb.ru","getApiDocumentState"));
//Параметры3.uuid = "ABCDEF";


////Результат = WSПрокси.getApiDocumentState("58861");
////Результат = WSПрокси.findNewErpDocumentsWithLimit(Параметры2);
//Результат = WSПрокси.getApiDocumentState(Параметры3);

//Сообщить(Результат);




КонецПроцедуры
