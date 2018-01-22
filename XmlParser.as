package 
{
	
	
	import flash.display.*;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.* 
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	
	
	/**
	 * ...
	 * @author ziplex
	 */
		
	 public class XmlParser extends Sprite
	{
	   
	   
		
		 /**
		 *   массив ссылок на полноформатные изображения
		 */ 
		 public var labels:Array = [];
		 /**
		 *   массив ссылок миниатюрных битмапов
		 */ 
		 public var datas:Array = [];
		 /**
		  * массив подписей к изображению
		  */
		 public var Description:Array = [];
		/**
		*    лист XML
		*/ 
		 public var ParserXmlList:XMLList;
		 /**
	    *   счетчик, хранит кол-во битмапов
		*/ 
		 public var TotalListIndex:int=0;
		 /**
		*   текст ошибок, при загрузке 
		*/ 
		 public var ErrorText:String;
		 public var xmlData:XML;
		
		 
		
		
		/**
		 * 
		 * @param	url -путь к XML файлу
		 * @param	func -  функция вызывается в случае завершения загрузки
		 * @param	err - функция вызывается в случае возникновения ошибки
		 */
	
	public function loadXML(url:String,func:Function=null,err:Function=null):void
	{
									
									trace("Loade...",url);
									//создаем загрузчик XML
									var ParserXmlLoader:URLLoader = new URLLoader();
																		
																		
									ParserXmlLoader.addEventListener(Event.COMPLETE, processParserXML);
									ParserXmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ParserXmlIOerror);
									ParserXmlLoader.addEventListener(IOErrorEvent.VERIFY_ERROR, ParserVeryfyIOerror);	
									ParserXmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onCecrErr);
									ParserXmlLoader.load(new URLRequest(url));
									
						
									function onCecrErr(event:Event):void
									{
										ErrorText= event.toString()+url;
										trace ("Error Secure config.xml ", ErrorText);
										err();
									}
									
									
									function ParserVeryfyIOerror(event:Event):void
									{
										ErrorText = event.toString()+url;
										trace("Error Parser.xml",url)
										err()
									}
									function ParserXmlIOerror(event:Event):void
									{
										ErrorText = event.toString()+url;
										trace("Error Verify Parser.xml",url);
										err();
									}
									
									function processParserXML(event:Event):void 
										{
											
											var myXML:XML = new XML(event.target.data);
											xmlData = myXML;
											ParserXmlList = myXML.item;
											TotalListIndex = ParserXmlList.length();
											ParserXmlLoader.removeEventListener(Event.COMPLETE, processParserXML);
											ParserXmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ParserXmlIOerror);
											ParserXmlLoader.removeEventListener(IOErrorEvent.VERIFY_ERROR, ParserVeryfyIOerror);	
											ParserXmlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onCecrErr);
											//вызываем парсер
											parser();
											
										}
										
										function parser():void
										{  
											
											for(var i:int = 0; i < TotalListIndex; i++)
											{
												//заполняем массивы значениями из XML
												labels[i] = ParserXmlList[i].@label;
												datas[i] = ParserXmlList[i].@data;
												//Description[i]=ParserXmlList[i].@TXT;
											}
											//вызываем функцию
											func();
										}
										
									
										
								} //end function LoadXml
								
	}//end public class XmlParser
	
} 