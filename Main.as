package 
{
	
	import fl.controls.CheckBox;
	import fl.data.DataProvider;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import fl.controls.ComboBox;
	import flash.events.*;
	import fl.events.DataChangeEvent;
	import fl.events.ListEvent;
	import flash.text.TextField;
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	import fl.events.SliderEvent;
	import fl.controls.DataGrid;
	import fl.events.DataGridEvent;
	import fl.controls.dataGridClasses.DataGridColumn;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.filters.*;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.StageDisplayState;
	/**
	 * ...
	 * @author ziplex
	 */
	public class Main extends Sprite 
	{
		/**
		 *  комбобокс выбор типа помещения
		 */
		private var typeRoomCombo:ComboBox = new ComboBox();
		/**
		 *  комбобокс выбор пола
		 */
		private var floorCombo:ComboBox = new ComboBox();
		/**
		 *  комбобокс выбор стен
		 */
		private var wallCombo:ComboBox = new ComboBox();
		/**
		 *  комбобокс выбор потолка
		 */
		private var ceilingCombo:ComboBox = new ComboBox();
		/**
		 *  комбобокс выбор мебели
		 */
		private var furnitureCombo:ComboBox = new ComboBox();
		/**
		 * таблица с данными
		 */
		private var MainDataTable:DataGrid = new DataGrid();
		/**
		 * основной источник данных
		 */
		private var mainDataProvider:DataProvider = new DataProvider();
		/**
		 * ползунок для цены
		 */
		private var PriceChanger:Slider = new Slider();
		/**
		 * Чекбокс Наличие в екатеринбурге
		 */
		private var EburgChk:CheckBox = new CheckBox();
		/**
		 * Чекбокс Акции и скидки
		 */
		private var ActionChk:CheckBox = new CheckBox();
		/**
		 *  таймлайн для viwer'a
		 */
		private var timelineViwer:TimelineLite = new TimelineLite();
		/**
		 *  для проверки что нажато
		 */
		private var changer:String;
		/**
		 * идентификатор обоины
		 */
		private var W_id:String="w01";
		/**
		 * идентификатор потолка
		 */
		private var S_id:String="s01";
		/**
		 * идентификатор мебели
		 */
		private var F_id:String="mebel_00";
		/**
		 *  путь в отображаторе
		 */
		private var path:String = "images/otobrajator/";
		/**
		 *  путь к большим изображениям
		 */
		private var fullPath:String = "images/otobrajator/";
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			// удаляем слушателей, задаем переменные
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/**
			 * основной контейнер - содержит все что на сцене
			 */
			var GlobalContainer:Sprite = new Sprite();
			var mainPage:MainPage = new MainPage();
			/**
			 * отступ слева
			 */
			var left:int = 25; 
			/**
			 * ширина миниатюры
			 */
			var thmb_width:Number = 71;
			/**
			 * высота миниатюры
			 */
			var thmb_height:Number = 71;
			/**
			 * ширина вьювера
			 */
			var viwer_width:Number = 715;
			/**
			 * высота вьювера
			 */
			var viwer_height:Number = 405;
			/**
			 * ширина таблицы
			 */
			var table_width:Number = 715;
			/**
			 * высота таблицы
			 */
			var table_height:Number = 85;
			/**
			 * подпись тип помещения
			 */
			var typeRoomTxt:TextField = new TextField();
			/**
			 * подпись пол
			 */
			var floorTxt:TextField = new TextField();
			/**
			 * подпись стены
			 */
			var wallTxt:TextField = new TextField();
			/**
			 * подпись потолок
			 */
			var ceilingTxt:TextField = new TextField();
			/**
			 * подпись мебель
			 */
			var furnitureTxt:TextField = new TextField();
			/**
			 * контейнер просмотрщика
			 */
			var viwercontainer:Sprite = new Sprite();
			/**
			 * ширина картинки в отображаторе
			 */
			var v_wdth:Number = 238;
			/**
			 * высота картинки в отображаторе
			 */
			var v_hdth:Number = 135;
			/**
			 * элементы в отображаторе
			 */
			var viwers:Array = [];
			
			//создаем массив ссылок на полы
				var floors:Array = [];
				//создаем массив ссылок на стены
				var walls:Array = [];
				//создаем массив ссылок на потолки
				var ceilings:Array = [];
				//создаем массив ссылок на мебель
				var furnitures:Array = [];
			//задаем xml парсеры для всех типов
			/**
			 * парсер для полов
			 */
			var floorXML:XmlParser = new XmlParser();
			/**
			 * парсер для стен
			 */
			var wallXML:XmlParser = new XmlParser();
			/**
			 * парсер для потолков
			 */
			var ceilingXML:XmlParser = new XmlParser();
			/**
			 * парсер для мебели
			 */
			var furnitureXML:XmlParser = new XmlParser();
			/**
			 * большое изображение
			 */
			var fullPicture:PicLoader = new PicLoader();
			/**
			*  чернобелый фильтр
			*/
			var BWfilter:ColorMatrixFilter = new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0, 
																	0.3086, 0.6094, 0.082, 0, 0,
																	0.3086, 0.6094, 0.082, 0, 0, 
																	0, 0, 0, 1, 0]); 
			//======= размещаем основные объекты на сцене и задаем им параметры
			
			//размещаем элемент комбобокс тип помещения  и подпись к нему и добавляем все в основной контейнер
			/*typeRoomTxt.text = "Тип помещения";
			typeRoomTxt.selectable = false;
			typeRoomTxt.x = left;
			typeRoomTxt.y = 40;
			GlobalContainer.addChild(typeRoomTxt);*/
			
			var typeHeader:ComboHeader = new ComboHeader();
			
			typeHeader.label = "Тип помещения:";
			typeHeader.label2 = "(выберите помещение)";
			typeHeader.x = left;
			typeHeader.y = 40;
			typeHeader.Width = 130;
			typeHeader.addEventListener(MouseEvent.CLICK, typeHeaderClick);
			//проверяем был ли открыт выбор помещения
			var typeHeaderOpened:Boolean = false;
			//обрабатываем нажатие на заголовок выбора комнаты;
			function typeHeaderClick():void 
			{
				typeHeader.selected = true;
				if(typeHeaderOpened)
				{
					typeRoomCombo.close();
					
				}
				else
				{
					typeRoomCombo.open();
				}
				//typeHeaderOpened = !typeHeaderOpened;
			}
			
			typeRoomCombo.x = left;
			typeRoomCombo.y = 58;
			typeRoomCombo.width = 130;
			typeRoomCombo.rowCount = 100;
			GlobalContainer.addChild(typeRoomCombo);
			GlobalContainer.addChild(typeHeader);
			//рисуем просмотровый контейнер и размещаем его на сцене
			viwercontainer.graphics.lineStyle(1, 0xE0E0E0, 1)
			viwercontainer.graphics.drawRect(0, 0, viwer_width, viwer_height);
			viwercontainer.graphics.endFill();
			
			viwercontainer.x = left;
			viwercontainer.y = 120;
			//CreateRow(viwers, viwercontainer, 9, 3, 0, v_wdth, v_hdth);
			GlobalContainer.addChild(viwercontainer);
			
			//размещаем таблицу
			
			
			MainDataTable.setSize(table_width, table_height);
			MainDataTable.columns = ["Поверхность", "Материал", "Цена", "S(площадь)", "Стоимость", "Поставщик"];
			
			MainDataTable.sortableColumns = false;
			MainDataTable.editable = true;
			MainDataTable.columns[0].editable = false;
			MainDataTable.columns[1].editable = false;
			MainDataTable.columns[2].editable = false;
			MainDataTable.columns[4].editable = false;
			MainDataTable.columns[5].editable = false;
						
			MainDataTable.x = left;
			MainDataTable.y = 550;
			MainDataTable.addEventListener(DataGridEvent.ITEM_FOCUS_OUT, editOut);
			GlobalContainer.addChild(MainDataTable);
			
			//считаем стоимость
			function editOut(event:Event):void 
			{
				
				
				var cont:uint = MainDataTable.selectedIndex;
				var objx:Object = mainDataProvider.getItemAt(cont);
				var num:Number=new Number(objx["Цена"] * objx["S(площадь)"]);
				objx["Стоимость"] = Number(num.toFixed(2));
				//objx["Стоимость"] = objx["Цена"] * objx["S(площадь)"];
				
			}
			
			//размещаем копирайт
			var copiright:TextField = new TextField();
			copiright.selectable = false;
			copiright.textColor = 0x969696;
			copiright.autoSize = TextFieldAutoSize.LEFT;
			copiright.text = "© 2009-2010 Студия Nautilus";
			copiright.x = MainDataTable.x;
			copiright.y = MainDataTable.y + MainDataTable.height + 5;
			GlobalContainer.addChild(copiright);
			
			//размещаем элементы выбора материалов для поверхностей
			// размещение комбобоксов по X Y
			var combosX:Number = 840;
			var combosY:Number = 23;
			//рисуем кнопку выбора пола
			
			var floorBox:Radiobox = new Radiobox();
			floorBox.colorBox = 0xFF0000;
			floorBox.label = "Пол";
			floorBox.x = left + viwercontainer.width+20;
			floorBox.y = combosY+5;
			//GlobalContainer.addChild(floorBox);
						
			var floorHeader:ComboHeader = new ComboHeader();
			
			floorHeader.label = "Пол:";
			floorHeader.label2 = "(.....)";
			floorHeader.x = left + viwercontainer.width+20;
			floorHeader.y = 40;
			floorHeader.Width = 100;
			floorHeader.addEventListener(MouseEvent.CLICK, floorHeaderClick);
			//проверяем был ли открыт выбор помещения
			var floorHeaderOpened:Boolean = false;
			//обрабатываем нажатие на заголовок выбора пола;
			function floorHeaderClick():void 
			{
				floorHeader.selected = true;
				wallHeader.selected = false;
				ceilingHeader.selected = false;
				furnitureHeader.selected = false;
				if(floorHeaderOpened)
				{
					floorCombo.close();
					
				}
				else
				{
					floorCombo.open();
				}
				//typeHeaderOpened = !typeHeaderOpened;
			}
			
			
			floorCombo.x = floorHeader.x;
			floorCombo.y = 58;
			floorCombo.rowCount = 100;
			GlobalContainer.addChild(floorCombo);
			GlobalContainer.addChild(floorHeader);
			
			//выбор стен
			//рисуем кнопку выбора стен
			var wallBox:Radiobox = new Radiobox();
			wallBox.colorBox = 0xFF0000;
			wallBox.label = "Стены";
			wallBox.x = left + viwercontainer.width+20;
			wallBox.y = combosY*2+5;
			//GlobalContainer.addChild(wallBox);
			
			var wallHeader:ComboHeader = new ComboHeader();
			
			wallHeader.label = "Стены:";
			wallHeader.label2 = "(.....)";
			wallHeader.x = floorHeader.x+floorHeader.width;
			wallHeader.y = 40;
			wallHeader.Width = 100;
			wallHeader.addEventListener(MouseEvent.CLICK, wallHeaderClick);
			//проверяем был ли открыт выбор помещения
			var wallHeaderOpened:Boolean = false;
			//обрабатываем нажатие на заголовок выбора стен;
			function wallHeaderClick():void 
			{
				floorHeader.selected = false;
				wallHeader.selected = true;
				ceilingHeader.selected = false;
				furnitureHeader.selected = false;
				if(wallHeaderOpened)
				{
					wallCombo.close();
					
				}
				else
				{
					wallCombo.open();
				}
				//typeHeaderOpened = !typeHeaderOpened;
			}
			
			wallCombo.x = wallHeader.x;
			wallCombo.y = 58;
			wallCombo.rowCount = 100;
			GlobalContainer.addChild(wallCombo);
			GlobalContainer.addChild(wallHeader);
			
			//размещаем элементы выбора материалов для поверхностей
			//рисуем кнопку выбора потолка
			var ceilingBox:Radiobox = new Radiobox();
			ceilingBox.colorBox = 0xFF0000;
			ceilingBox.label = "Потолок";
			ceilingBox.x = left + viwercontainer.width+20;
			ceilingBox.y = combosY*3+5;
			//GlobalContainer.addChild(ceilingBox);
			
			var ceilingHeader:ComboHeader = new ComboHeader();
			
			ceilingHeader.label = "Потолок:";
			ceilingHeader.label2 = "(.....)";
			ceilingHeader.x = wallHeader.x+wallHeader.width;
			ceilingHeader.y = 40;
			ceilingHeader.Width = 100;
			ceilingHeader.addEventListener(MouseEvent.CLICK, ceilingHeaderClick);
			//проверяем был ли открыт выбор помещения
			var ceilingHeaderOpened:Boolean = false;
			//обрабатываем нажатие на заголовок выбора стен;
			function ceilingHeaderClick():void 
			{
				floorHeader.selected = false;
				wallHeader.selected = false;
				ceilingHeader.selected = true;
				furnitureHeader.selected = false;
				if(ceilingHeaderOpened)
				{
					ceilingCombo.close();
					
				}
				else
				{
					ceilingCombo.open();
				}
				//typeHeaderOpened = !typeHeaderOpened;
			}
			
			
			ceilingCombo.x = ceilingHeader.x;
			ceilingCombo.y = 58;
			ceilingCombo.rowCount = 100;
			GlobalContainer.addChild(ceilingCombo);
			GlobalContainer.addChild(ceilingHeader);
			
			//размещаем элементы выбора материалов для поверхностей
			//рисуем кнопку выбора мебели
			var furnitureBox:Radiobox = new Radiobox();
			furnitureBox.colorBox = 0xFF0000;
			furnitureBox.label = "Мебель";
			furnitureBox.x = left + viwercontainer.width+20;
			furnitureBox.y = combosY*4+5;
			//GlobalContainer.addChild(furnitureBox);
			
			var furnitureHeader:ComboHeader = new ComboHeader();
			
			furnitureHeader.label = "Мебель:";
			furnitureHeader.label2 = "(.....)";
			furnitureHeader.x = ceilingHeader.x+ceilingHeader.width;
			furnitureHeader.y = 40;
			furnitureHeader.Width = 100;
			furnitureHeader.addEventListener(MouseEvent.CLICK, furnitureHeaderClick);
			//проверяем был ли открыт выбор помещения
			var furnitureHeaderOpened:Boolean = false;
			//обрабатываем нажатие на заголовок выбора стен;
			function furnitureHeaderClick():void 
			{
				floorHeader.selected = false;
				wallHeader.selected = false;
				ceilingHeader.selected = false;
				furnitureHeader.selected = true;
				if(furnitureHeaderOpened)
				{
					furnitureCombo.close();
					
				}
				else
				{
					furnitureCombo.open();
				}
				//typeHeaderOpened = !typeHeaderOpened;
			}
			
			furnitureCombo.x = furnitureHeader.x;
			furnitureCombo.y = 58;
			furnitureCombo.rowCount = 100;
			GlobalContainer.addChild(furnitureCombo);
			GlobalContainer.addChild(furnitureHeader);
			
			//создаем контейнеры для превью
			var PreviewContainer:Sprite = new Sprite();
			var Prewiews:Array = [];
			CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height,false);
			
			PreviewContainer.x = floorBox.x;
			PreviewContainer.y = viwercontainer.y;
			GlobalContainer.addChild(PreviewContainer);
			
			var PriceTxtLeft:TextField = new TextField();
			PriceTxtLeft.selectable = false;
			PriceTxtLeft.text = "Цена Min";
			PriceTxtLeft.autoSize = TextFieldAutoSize.LEFT;
			PriceTxtLeft.y = -20;
			PriceChanger.addChild(PriceTxtLeft);
			
			var PriceTxtRight:TextField = new TextField();
			PriceTxtRight.selectable = false;
			PriceTxtRight.text = "Цена Max";
			PriceTxtRight.autoSize = TextFieldAutoSize.LEFT;
			PriceTxtRight.x = PreviewContainer.width - PriceTxtRight.textWidth-7;
			PriceTxtRight.y = -20;
			PriceChanger.addChild(PriceTxtRight);
			
			
			PriceChanger.x = PreviewContainer.x;
			PriceChanger.y = MainDataTable.y+15;
			PriceChanger.width = PreviewContainer.width;
			PriceChanger.maximum = 10000;
			PriceChanger.minimum = 100;
			PriceChanger.value = PriceChanger.maximum * 0.5;
			GlobalContainer.addChild(PriceChanger);
			//слушаем событие нажатия на ползунок
			PriceChanger.addEventListener(SliderEvent.THUMB_PRESS, onPricePress);
			
			function onPricePress(event:Event):void 
			{
				prompt.label = "    Возможность выбирать и  модифицировать диапазоны стоимости представленных товаров будут реализованы в последующих версиях программы";
			}
			
			EburgChk.label = "Наличие в Екатеринбурге";
			EburgChk.width = 300;
			EburgChk.x = PriceChanger.x;
			EburgChk.y = PriceChanger.y + 20;
			EburgChk.enabled = false;
			EburgChk.addEventListener(MouseEvent.CLICK, eburgClick);
			GlobalContainer.addChild(EburgChk);
			
			ActionChk.label = "Акции, скидки";
			ActionChk.width = 300;
			ActionChk.x = EburgChk.x;
			ActionChk.y = EburgChk.y + 20;
			ActionChk.enabled = false;
			ActionChk.addEventListener(MouseEvent.CLICK, actionClick);
			GlobalContainer.addChild(ActionChk);
			
			
			function eburgClick(event:MouseEvent):void 
			{
				var fltr:Boolean = event.target.selected;
				if(fltr){filtredEKB(); }
				else{unfiltredEKB(); }
			}
			
			function actionClick(event:Event):void 
			{
				var fltr:Boolean = event.target.selected;
				if(fltr){filtredAction(); }
				else{unfiltredAction(); }
			}
			
			//ф-ция создания сетки элементов
			/**
			 * 
			 * @param	content - массив объектов которые расположим 
			 * @param	container - куда запихнем массив
			 * @param	ttl - количество элементов
			 * @param	colum - количество столбцов
			 * @param	space - расстояние между объектами
			 * @param	wdth - ширина
			 * @param	hght - высота
			 * @param	masked - создает маску
			 */
			function CreateRow(content:Array,container:Sprite,ttl:int,colum:int,spase:int,wdth:Number,hght:Number,masked:Boolean=true):void 
			{
				//задаем счетчики по x и y
				var x_counter:Number = 0;
				var y_counter:Number = 0;
				for (var i:int = 0; i < ttl; i++) 
				{
					content[i] = new MovieClip();
				    var obj:Sprite = new Sprite();
					var maska:Sprite = new Sprite();
					
					obj.graphics.lineStyle(1, 0xE0E0E0, 1);
					obj.graphics.drawRect(0, 0, wdth, hght);
					obj.graphics.endFill();
					
					maska.graphics.lineStyle(5, 0xFF0000, 1);
					maska.graphics.beginFill(0xFF0000, 1);
					maska.graphics.drawRect(0, 0, wdth, hght);
					maska.graphics.endFill();
					
					content[i].addChild(obj);
					container.addChild(content[i]);
					if(masked)
					{
						container.addChild(maska);
						content[i].mask = maska;
						maska.x = (wdth + spase) * x_counter;
						maska.y = (hght + spase) * y_counter;
					}
					content[i].x = (wdth+spase)*x_counter;
					content[i].y = (hght + spase) * y_counter;
					

					if (x_counter + 1 < colum)
					{
						x_counter++;
					} 
					else 
					{
					  x_counter = 0;
					  y_counter++;
					}
				}
			}
			
			//загружаем основной XML 
			var xml:XmlParser = new XmlParser();
			xml.loadXML("typeroom.xml", onloadXML);
			//для типов комнат 
			var typeRoomXML:XmlParser = new XmlParser();
			var dt:DataProvider;
			//создаем подсказку;
			var prompt:PromptLabel = new PromptLabel();
			prompt.label = "    Выберите тип помещения";
			prompt.Width = viwer_width-typeRoomCombo.width;
			prompt.Height = 40;
			prompt.x = typeRoomCombo.x + typeRoomCombo.width;//+40;
			prompt.y = 40;
			GlobalContainer.addChild(prompt);
			var errorMessage:MessageBox = new MessageBox();
			errorMessage.addEventListener("ClickNext", onNext);
			errorMessage.addEventListener("ClickPrev", onPrev);
			
			function onNext(event:Event):void 
			{
				GlobalContainer.removeChild(errorMessage);
				loadPrewiewPicture();
				floorXML.loadXML(floors[4], onLoadFloors);
				wallXML.loadXML(walls[4], onLoadWalls);
				ceilingXML.loadXML(ceilings[4], onLoadCeilings);
				furnitureXML.loadXML(furnitures[4], onLoadFurniture);
				//viwercontainer.addEventListener(MouseEvent.CLICK, onViwerContainerClick);
				//если впервые загрузка то подписываем кнопки выбора
					if(FirstLoad)
					{
						floorHeader.label2 = "(выбор пола)";
						wallHeader.label2 = "(выбор стен)";
						ceilingHeader.label2 = "(выбор потолка)";
						furnitureHeader.label2 = "(выбор мебели)";
						
						var obj1:Object = new Object();
						obj1 = { "Поверхность":"Пол", "Материал":"Дерево", "Цена":100, "S(площадь)":"", "Стоимость":"", "Поставщик":"ООО ПОЛ" };
						
						mainDataProvider.addItemAt(obj1, 0);
						obj1 = { "Поверхность":"Стены", "Материал":"Флазелин", "Цена":100, "S(площадь)":"", "Стоимость":"", "Поставщик":"ООО Стены" };
						mainDataProvider.addItemAt(obj1, 1);
						obj1 = { "Поверхность":"Потолок", "Материал":"Флазелин", "Цена":100, "S(площадь)":"", "Стоимость":"", "Поставщик":"ООО Потолок" };
						mainDataProvider.addItemAt(obj1, 2);
						//mainDataProvider.addItemAt(null, 3);
						MainDataTable.dataProvider = mainDataProvider;
						FirstLoad = !FirstLoad;
						
					}
			}
			function onPrev(event:Event):void 
			{
				GlobalContainer.removeChild(errorMessage);
			}
			
			//при нажатии на контейнер с изображением
			function onViwerContainerClick(event:Event):void 
			{
				    
					
					var urlr:String = fullPath + F_id + "/" + W_id + "_" + S_id + ".jpg";
					trace(urlr);
					
					fullPicture.LoadPic(urlr, GlobalContainer.width, GlobalContainer.height, "linear", fload, GlobalContainer);
					function fload():void
					{
						
						GlobalContainer.addChild(fullPicture);
						trace("загружено");
						fullPicture.buttonMode = true;
						stage.displayState = StageDisplayState.FULL_SCREEN;
						fullPicture.addEventListener(MouseEvent.CLICK, onfullClick);
					}
			}
			//кликнули на большое изображение убиваем его и слушатель
			function onfullClick(event:Event):void 
			{
				GlobalContainer.removeChild(fullPicture);
				fullPicture.removeEventListener(MouseEvent.CLICK, onfullClick);
				stage.displayState = StageDisplayState.NORMAL;
			}
			
			//после загрузки добавляем основной контейнер на сцену 
			//данные из xml  в комбобокс выбора комнаты
			function onloadXML():void 
			{
				//задаем датапровайдера
				dt = new DataProvider(xml.xmlData);
				typeRoomCombo.dataProvider = dt;
				//добавляем все на сцену
				addChild(GlobalContainer);
				GlobalContainer.addChild(mainPage);
				//рисуем основную рамку
				GlobalContainer.graphics.lineStyle(1, 0xF4F4F4, 1);
				GlobalContainer.graphics.drawRect(0, 0, 1200, 700);
				GlobalContainer.graphics.endFill();
				//слушаем комбобокс на событие выбора
				typeRoomCombo.addEventListener(Event.CHANGE, onTypeRoomChange);
				typeRoomCombo.addEventListener(ListEvent.ITEM_ROLL_OVER, typeRoomRollOverHandler);
				typeRoomCombo.addEventListener(Event.CLOSE, onTypeRoomClose);
				typeRoomCombo.addEventListener(Event.OPEN, onTypeRoomClose);

			}
			
			function onTypeRoomClose(event:Event):void 
			{
				typeHeaderOpened = !typeHeaderOpened;
				
			}
			
			//вызываем при наведении на выбор типа комнаты
			function typeRoomRollOverHandler(event:ListEvent):void 
			{
				var rowIdx:uint = event.rowIndex as uint;
				var label:String = typeRoomCombo.getItemAt(rowIdx).label; 
				var dat:String = typeRoomCombo.getItemAt(rowIdx).data;
				if (dat != "null")
				{
				  prompt.label = "    Здесь Вы можете выбрать помещение типа: "+label;
				}
				else
				{
					prompt.label = "    Тип помещения: "+label+" в данной версии не предусмотрен" ;
				}
				
				trace("ComboBox itemRollOver: " + "`" + typeRoomCombo.getItemAt(rowIdx).data);

			}
			//когда выбрали из списка получаем данные того что выбрали
			function onTypeRoomChange(event:Event):void 
			{
				viwercontainer.removeEventListener(MouseEvent.CLICK, onViwerContainerClick);
				spiner.enabled = false;
				//удаляем все элементы во вьювере и выбираторе
				while (viwercontainer.numChildren > 0) { viwercontainer.removeChildAt(0) };
				while (PreviewContainer.numChildren > 0) { PreviewContainer.removeChildAt(0) };
				//создаем заново пустую сетку выбиратора
				CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height,false);
				//все данные обнуляем и лочим
				floorBox.select = false;
				wallBox.select = false;
				ceilingBox.select = false;
				furnitureBox.select = false;
				EburgChk.selected = false;
				ActionChk.selected = false;
				EburgChk.enabled = false;
				ActionChk.enabled = false;
				var nuldata:DataProvider = new DataProvider();
					floorCombo.dataProvider = nuldata;
					wallCombo.dataProvider = nuldata;
					ceilingCombo.dataProvider = nuldata;
					furnitureCombo.dataProvider = nuldata;
				
				trace(typeRoomCombo.selectedItem.data);
				//задаем итем для проверки что он не нулевой
				var item:String = typeRoomCombo.selectedItem.data;
				var label:String = "    Вы выбрали помещение типа: " + typeRoomCombo.selectedItem.label;
				typeHeader.label2=typeRoomCombo.selectedItem.label;
				typeHeader.italicFont = false;
				typeHeader.fontSize = 12;
				if (item != "null")
				{
				 //если элемент был не нулевой, грузим xml  из data
					typeRoomXML.loadXML(typeRoomCombo.selectedItem.data, onLoadRoom);
					prompt.label = label;
				}
				else
				{
					//удаляем все элементы во вьювере и выбираторе
					while (viwercontainer.numChildren > 0) { viwercontainer.removeChildAt(0) };
					while (PreviewContainer.numChildren > 0) { PreviewContainer.removeChildAt(0) };
					//создаем заново пустую сетку выбиратора
					CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height,false);
					//все данные обнуляем и лочим
					floorBox.select = false;
					wallBox.select = false;
					ceilingBox.select = false;
					furnitureBox.select = false;
					EburgChk.selected = false;
					ActionChk.selected = false;
					EburgChk.enabled = false;
					ActionChk.enabled = false;
					
					
					
					floorCombo.dataProvider = nuldata;
					wallCombo.dataProvider = nuldata;
					ceilingCombo.dataProvider = nuldata;
					furnitureCombo.dataProvider = nuldata;
									
					spinviwer.enabled = false;
					spinviwer.value = 0;
					prompt.label = label+", которое в данной версии не предусмотрено";
				}
			}
			
			function onLoadRoom():void 
			{
				s = 0;
				loadViwers();
				
			}
			/**
			 * счетчик нажатий 
			 */
			var s:int = 0;
			/**
			 * создаем стрелки
			 */
			var spiner:SpinClicker = new SpinClicker;
			spiner.size = 10;
			spiner.distance = 10;
			spiner.showline = false;
			spiner.x = viwercontainer.x + viwercontainer.width - spiner.width - 10;
			spiner.y = viwercontainer.y +viwercontainer.height + 5; 
			GlobalContainer.addChild(spiner);
			spiner.addEventListener("ChangeSpin", onClickSpiner);
			
			//при нажатии на стрелки вызываем функцию 
			
			function onClickSpiner(event:Event):void 
			{
				
				spiner.stop();
				s = spiner.value;
				loadViwers();
			}
			
			
			function loadViwers():void
			{
				//убиваем все что было во вьювере
				while (viwercontainer.numChildren > 0) { viwercontainer.removeChildAt(0) };
				//создаем вновь сетку отображения
				CreateRow(viwers, viwercontainer, 9, 3, 0, v_wdth, v_hdth);
				//задаем лист ссылок на изображения
				var ImgList:XMLList = new XMLList();
				ImgList = typeRoomXML.ParserXmlList;
				//запоминаем количество изображений
				var total:int = typeRoomXML.TotalListIndex;
				//создаем массив ссылок на изображения
				var urls:Array = [];
				spiner.MAX = total;
				//если изображений больше 9 то тотал равен 9 врубаем листалки
				if (total > 9) 
				{ total = 9 
				  spiner.enabled = true;	
				}
				else
				{
					spiner.enabled = false;
				}
				//счетчик
				var cnt:int;
				//количество изображений
				var ttl:int = typeRoomXML.TotalListIndex;;
				for (var i:int = 0; i < total; i++) 
				{
					//счетчик равен сумме элемента из цикла и значение шага спинера
					cnt = i + s;
					//если следущее значение счетчика больше кол-ва изображений делаем счетчик равным меньше на единицу
					// а ссылки на изображения делаем на пустую картинку
					if (cnt+1 > ttl) 
					{ 
						cnt = ttl - 1 
						urls[i] = null;//"images/null.jpg";
					}
					else
					{
						urls[i] = ImgList[cnt].@img;
					}
					
					
					floors[i] = ImgList[cnt].@floor;
					walls[i] = ImgList[cnt].@walls;
					ceilings[i] = ImgList[cnt].@ceiling;
					furnitures[i] = ImgList[cnt].@furniture;
					viwers[i].value = cnt;
					//если дата нулевая тогда делаем картинку чернобелой
					if (typeRoomXML.ParserXmlList[cnt].@data == null)
					{
						viwers[i].filters=[BWfilter]
					}
				}
				//удаляем слушателей
				removeEventListinersViwers(viwers, total);
				var pldr:PicLoader = new PicLoader();
				pldr.LoadPictures(urls, viwers, total, v_wdth, v_hdth);
				//добавляем слушателей
				addEventListinersViwers(viwers, total);
				spiner.play();
				
			}
			
			/**
			 * задаем слушателей на вьюверы
			 * @param	obj-массив объектов которым будут заданы слушатели
			 * @param  col - количество объектов
			 */
			function addEventListinersViwers(obj:Array,col:int):void 
			{
				for (var i:int = 0; i <col ; i++) 
				{
					//определяем слушатели
					obj[i].addEventListener(MouseEvent.CLICK, onClickView);
					obj[i].addEventListener(MouseEvent.MOUSE_OVER, onOverView);
					obj[i].addEventListener(MouseEvent.MOUSE_OUT, onOutView);
					//делаем объекты кнопками
					obj[i].buttonMode = true;
				}
			}
			
			/**
			 * убиваем слушателей на вьюверы
			 * @param	obj-массив объектов у которых будут удалены слушатели
			 * @param  col - количество объектов
			 */
			function removeEventListinersViwers(obj:Array,col:int):void 
			{
				for (var i:int = 0; i <col ; i++) 
				{
					//определяем слушатели
					obj[i].removeEventListener(MouseEvent.CLICK, onClickView);
					obj[i].removeEventListener(MouseEvent.MOUSE_OVER, onOverView);
					obj[i].removeEventListener(MouseEvent.MOUSE_OUT, onOutView);
					//убираем объекты кнопки
					obj[i].buttonMode = false;
				}
			}
			
			
			//проверка на то что загрузка была впервые
			var FirstLoad:Boolean = true;
			//слушаем нажатие на вьювер
			function onClickView(event:MouseEvent):void 
			{
				spiner.enabled = false;
				//разыминовываем нажатый клип как мувик
				var button:MovieClip = (event.currentTarget as MovieClip);
				//запоминаем значение мувика
				var id:int = button.value;
				trace("ID=", id);
				//если не пустая дата грузим картинку во весь рост и добавляем слушателя на контейнер
				if (typeRoomXML.ParserXmlList[id].@data != null)
				{
					loadPrewiewPicture();
					floorXML.loadXML(floors[id], onLoadFloors);
					wallXML.loadXML(walls[id], onLoadWalls);
					ceilingXML.loadXML(ceilings[id], onLoadCeilings);
					furnitureXML.loadXML(furnitures[id], onLoadFurniture);
					
					//если впервые загрузка то подписываем кнопки выбора
					if(FirstLoad)
					{
						floorHeader.label2 = "(выбор пола)";
						wallHeader.label2 = "(выбор стен)";
						ceilingHeader.label2 = "(выбор потолка)";
						furnitureHeader.label2 = "(выбор мебели)";
						
						var obj1:Object = new Object();
						obj1 = { "Поверхность":"Пол", "Материал":"Дерево", "Цена":100, "S(площадь)":"", "Стоимость":"", "Поставщик":"ООО ПОЛ" };
						
						mainDataProvider.addItemAt(obj1, 0);
						obj1 = { "Поверхность":"Стены", "Материал":"Флазелин", "Цена":100, "S(площадь)":"", "Стоимость":"", "Поставщик":"ООО Стены" };
						mainDataProvider.addItemAt(obj1, 1);
						obj1 = { "Поверхность":"Потолок", "Материал":"Флазелин", "Цена":100, "S(площадь)":"", "Стоимость":"", "Поставщик":"ООО Потолок" };
						mainDataProvider.addItemAt(obj1, 2);
						//mainDataProvider.addItemAt(null, 3);
						MainDataTable.dataProvider = mainDataProvider;
						FirstLoad = !FirstLoad;
						
					}
				}
				else
				{
					errorMessage.url = path + F_id + "/" + W_id + "_" + S_id + ".jpg";
					GlobalContainer.addChild(errorMessage);
					trace("data is null", typeRoomXML.ParserXmlList[id].@img);
				}
				
			}
			/**
			 * загружаем готовое изображение в отображатор
			 */
			
			function loadPrewiewPicture():void 
			{
				
				//убиваем все что было во вьювере
					//while (viwercontainer.numChildren > 0) { viwercontainer.removeChildAt(0) };
					var picload:PicLoader = new PicLoader();
					viwercontainer.addChild(picload);
					var urlr:String = path + F_id + "/" + W_id + "_" + S_id + ".jpg";
					trace(urlr);
					
					picload.LoadPic(urlr, viwer_width, viwer_height, "linear", fload, viwercontainer);
					function fload():void
					{
						//добавляем слушатель на контейнер
						viwercontainer.addEventListener(MouseEvent.CLICK, onViwerContainerClick);
						viwercontainer.removeChildAt(0);
						viwercontainer.buttonMode = true;
					}
			}
			
			function err():void 
			{
				trace(xml.ErrorText);
			}
			
			
			//слушаем мышь на вход во вьювер
			function onOverView(event:MouseEvent):void 
			{
				//разыминовываем нажатый клип как мувик
				var button:MovieClip = (event.currentTarget as MovieClip);
				//запоминаем значение мувика
				var id:int = button.value;
				trace("OverID=", id);
				var tl:TimelineLite = new TimelineLite();
				tl.append(TweenLite.to(button, 0.85, { scaleX:1.1,scaleY:1.1} ));
				tl.play();
				
				
			}
			//слушаем мышь на выход из вьювера
			function onOutView(event:MouseEvent):void 
			{
				//разыминовываем нажатый клип как мувик
				var button:MovieClip = (event.currentTarget as MovieClip);
				//запоминаем значение мувика
				var id:int = button.value;
				trace("OutID=", id);
				var tl:TimelineLite = new TimelineLite();
				tl.append(TweenLite.to(button, 0.5, { scaleX:1,scaleY:1} ));
				tl.play();
				
			}
//=================================================мебель==============================

			function onLoadFurniture():void 
			{
				//задаем датапровайдера
				var dpv:DataProvider;
				dpv = new DataProvider(furnitureXML.xmlData);
				furnitureCombo.dataProvider = dpv;
				trace(floorXML.xmlData);
				//слушаем комбобокс на событие выбора
				furnitureCombo.addEventListener(Event.CHANGE, onFurChange);
				furnitureCombo.addEventListener(Event.OPEN, onFurChange);
			}
			
			function onFurChange(event:Event):void 
			{
				
				
				floorBox.select = false;
				wallBox.select = false;
				ceilingBox.select = false;
				furnitureBox.select = true;
				EburgChk.enabled = false;
				ActionChk.enabled = false;
				EburgChk.selected = false;
				ActionChk.selected = false;
				
				furnitureHeader.label2=furnitureCombo.selectedItem.label;
				furnitureHeader.italicFont = false;
				furnitureHeader.fontSize = 12;
				var datas:String = furnitureCombo.selectedItem.data;
				var surface:String = furnitureCombo.selectedItem.surface;
				var material:String = furnitureCombo.selectedItem.material;
				var price:Number = furnitureCombo.selectedItem.price;
				var provider:String = furnitureCombo.selectedItem.provider;
				F_id=furnitureCombo.selectedItem.id;
				
				trace(datas, surface, material, price, provider,S_id);
				/*var obj1:Object = new Object();
				obj1 = { "Поверхность":surface, "Материал":material, "Цена":price, "S(площадь)":"", "Стоимость":"", "Поставщик":provider };
				
				mainDataProvider.removeItemAt(3);
				mainDataProvider.addItemAt(obj1, 3);
				MainDataTable.dataProvider = mainDataProvider;*/
				
				
					//убиваем все что было во вьювере
					while (PreviewContainer.numChildren > 0) { PreviewContainer.removeChildAt(0) };
					//создаем заново пустую сетку выбиратора
					CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height, false);
					spinviwer.enabled = false;
					spinviwer.value = 0;
				
				loadPrewiewPicture();
				
				
			}
			
//==================================================потолки=======================
//==================================================И прочее=======================

			function onLoadCeilings():void 
			{
				//задаем датапровайдера
				var dpv:DataProvider;
				dpv = new DataProvider(ceilingXML.xmlData);
				ceilingCombo.dataProvider = dpv;
				
				//слушаем комбобокс на событие выбора
				ceilingCombo.addEventListener(Event.CHANGE, onCeilChange);
				ceilingCombo.addEventListener(Event.OPEN, onCeilChange);
			}
			
			function onCeilChange(event:Event):void 
			{
				
				
				floorBox.select = false;
				wallBox.select = false;
				ceilingBox.select = true;
				furnitureBox.select = false;
				EburgChk.enabled = false;
				ActionChk.enabled = false;
				EburgChk.selected = false;
				ActionChk.selected = false;
				
				ceilingHeader.label2=ceilingCombo.selectedItem.label;
				ceilingHeader.italicFont = false;
				ceilingHeader.fontSize = 12;
				
				var datas:String = ceilingCombo.selectedItem.data;
				var surface:String = ceilingCombo.selectedItem.surface;
				var material:String = ceilingCombo.selectedItem.material;
				var price:Number = ceilingCombo.selectedItem.price;
				var provider:String = ceilingCombo.selectedItem.provider;
				S_id=ceilingCombo.selectedItem.id;
				
				trace(datas, surface, material, price, provider,S_id);
				
				
				var objx:Object = mainDataProvider.getItemAt(2);
				objx["Поверхность"] = "Потолок";
				objx["Материал"] = material;
				objx["Цена"] = price;
				objx["Поставщик"] = provider;
				var num:Number=new Number(objx["Цена"] * objx["S(площадь)"]);
				objx["Стоимость"] = Number(num.toFixed(2));
				MainDataTable.dataProvider = mainDataProvider;
				/*var obj1:Object = new Object();
				obj1 = { "Поверхность":surface, "Материал":material, "Цена":price, "S(площадь)":"", "Стоимость":"", "Поставщик":provider };
				
				mainDataProvider.removeItemAt(2);
				mainDataProvider.addItemAt(obj1, 2);
				MainDataTable.dataProvider = mainDataProvider;*/
				
				
					//убиваем все что было во вьювере
					while (PreviewContainer.numChildren > 0) { PreviewContainer.removeChildAt(0) };
					//создаем заново пустую сетку выбиратора
					CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height, false);
					spinviwer.enabled = false;
					spinviwer.value = 0;
				
				loadPrewiewPicture();
				
				
			}
			
			
			
			//=====================стены======================
			
			
			function onLoadWalls():void 
			{
				//задаем датапровайдера
				var dpv:DataProvider;
				dpv = new DataProvider(wallXML.xmlData);
				wallCombo.dataProvider = dpv;
				
				//слушаем комбобокс на событие выбора
				wallCombo.addEventListener(Event.CHANGE, onWallChange);
				wallCombo.addEventListener(Event.OPEN, onWallChange);
			}
			
			var wXML:XmlParser = new XmlParser();
			var glFilter:GlowFilter = new GlowFilter(0x00FF00, 0.9,10,10,3);
			var aFilter:GlowFilter = new GlowFilter(0x8000FF, 1, 80, 80, 2, 1, true, true);
			
			var vFormat:TextFormat = new TextFormat();
			vFormat.size = 40;
			vFormat.color = 0xFF0000;
			var v:Array = [];//TextField 
			
			
			
			
			// акции и скидки
			function filtredAction():void 
			{
				for (var i:int = 0; i < 25; i++) 
				{
					if (wXML.ParserXmlList[i].@sale != "no")
					{
						v[i] = new star(); //new TextField();
						v[i].label.text = wXML.ParserXmlList[i].@sale;
						v[i].label.selectable = false;
						//v[i].text = "25%";
						v[i].x = Prewiews[i].width -v[i].width*0.5-5;
						v[i].y = Prewiews[i].height -v[i].height*0.5-5;
						//v[i].setTextFormat(vFormat);
						Prewiews[i].addChild(v[i]);
					
						
					}
				}	
			}
			
			/**
			 *  убираем фильтр скидки
			 */
			function unfiltredAction():void 
			{
				for (var i:int = 0; i < 25; i++) 
				{
					if (wXML.ParserXmlList[i].@sale != "no")
					{
						Prewiews[i].removeChild(v[i]);
					}
				}	
			}
			
			// в наличии в ебурге
			function filtredEKB():void
			{
			   for (var i:int = 0; i < 25; i++) 
				{
					if (wXML.ParserXmlList[i].@ekb != "yes")
					{
						Prewiews[i].filters = [BWfilter];
						
					}
				}	
			}
			
			/**
			 *  убираем фильтр в наличии
			 */
			function unfiltredEKB():void 
			{
				for (var i:int = 0; i < 25; i++) 
				{
					Prewiews[i].filters = null;
				}	
			}
			
			function onWallChange(event:Event):void 
			{
				//выбраны стены
				changer = "wall";
				
				floorBox.select = false;
				wallBox.select = true;
				ceilingBox.select = false;
				furnitureBox.select = false;
				
				wallHeader.label2=wallCombo.selectedItem.label;
				wallHeader.italicFont = false;
				wallHeader.fontSize = 12;
				//задаем итем для проверки что он не нулевой
				var item:String = wallCombo.selectedItem.data;
				
				if (item != "null")
				{
				 //если элемент был не нулевой, грузим xml  из data
					wXML.loadXML(item, onLoadWallData);
					EburgChk.enabled = true;
				    ActionChk.enabled = true;
				}
				else
				{
					EburgChk.enabled = false;
				    ActionChk.enabled = false;
					EburgChk.selected = false;
					ActionChk.selected = false;
					//убиваем все что было во вьювере
					while (PreviewContainer.numChildren > 0) { PreviewContainer.removeChildAt(0) };
					//создаем заново пустую сетку выбиратора
					CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height, false);
					spinviwer.enabled = false;
					spinviwer.value = 0;
				}
			}
			
			//после того как загрузили данные о стенах
			function onLoadWallData():void 
			{
			    trace("Выбираем стены")
				f = 0; 
				createWalls(wXML);	
			}
			
			
			
			//создаем изображения стен
			function createWalls(xmldata:XmlParser):void 
			{
				//убиваем все что было во вьювере
				while (PreviewContainer.numChildren > 0) { PreviewContainer.removeChildAt(0) };
				CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height,false);
				//задаем лист ссылок на изображения
				var ImgList:XMLList = new XMLList();
				ImgList = xmldata.ParserXmlList;
				//запоминаем количество изображений
				var total:int = xmldata.TotalListIndex;
				//создаем массив ссылок на изображения
				var urls:Array = [];
				
				spinviwer.MAX = total;
				
				//если изображений больше 25 то тотал равен 25 врубаем листалки
				if (total > 25) 
				{ total = 25 
				  spinviwer.enabled = true;	
				}
				else
				{
					spinviwer.enabled = false;
				}
				//счетчик
				var cnt:int;
				//количество изображений
				var ttl:int = xmldata.TotalListIndex;;
				for (var i:int = 0; i < total; i++) 
				{
					//счетчик равен сумме элемента из цикла и значение шага спинера
					cnt = i + f;
					//если следущее значение счетчика больше кол-ва изображений делаем счетчик равным меньше на единицу
					// а ссылки на изображения делаем на пустую картинку
					if (cnt+1 > ttl) 
					{ 
						cnt = ttl - 1 
						urls[i] = null;//"images/null.jpg";
					}
					else
					{
						urls[i] = ImgList[cnt].@img;
					}
					
					Prewiews[i].value = cnt;
					//если дата нулевая тогда делаем картинку чернобелой
					if (xmldata.ParserXmlList[cnt].@data == null)
					{
						Prewiews[i].filters=[BWfilter]
					}
				}
				//удаляем слушателей
				removeEventListinersFloors(Prewiews, total);
				var pldr:PicLoader = new PicLoader();
				pldr.LoadPictures(urls, Prewiews, total, thmb_width, thmb_height);
				//добавляем слушателей
				addEventListinersFloors(Prewiews, total);
				//spiner.play();
				
				
			}
			
			
			
			//========================полы===================
			
			
			//создаем кнопки листалки для выбиратора
			
			var spinviwer:SpinClicker = new SpinClicker();
			spinviwer.x = PreviewContainer.x + PreviewContainer.width * 0.5-50;
			spinviwer.y = PreviewContainer.y + PreviewContainer.height + 5;
			spinviwer.distance = 60;
			spinviwer.step = 25;
			GlobalContainer.addChild(spinviwer);
			//счетчик
			var f:int = 0;
			spinviwer.addEventListener("ChangeSpin", onChangeSpinView);
			
			
			//при нажатии на стрелки вызываем функцию 
			
			function onChangeSpinView(event:Event):void 
			{
				
				
				f = spinviwer.value;
				
				
				if(changer=="floor")
				{
					createFlors(fXML);
				}
				else if (changer == "wall")
				{
					createWalls(wXML);
				}
			}
			
			
			
			//загрузили полы
			function onLoadFloors():void 
			{
				//задаем датапровайдера
				var dpv:DataProvider;
				dpv = new DataProvider(floorXML.xmlData);
				floorCombo.dataProvider = dpv;
				
				//слушаем комбобокс на событие выбора
				floorCombo.addEventListener(Event.CHANGE, onFloorChange);
				floorCombo.addEventListener(Event.OPEN, onFloorChange);
			}
			
			/**
			 * данные полов
			 */
			var fXML:XmlParser = new XmlParser();
			//слушаем выбор пола
			function onFloorChange(event:Event):void 
			{
				//выбран пол
				changer = "floor";
				floorBox.select = true;
				wallBox.select = false;
				ceilingBox.select = false;
				furnitureBox.select = false;
				
				EburgChk.enabled = false;
				ActionChk.enabled = false;
				EburgChk.selected = false;
				ActionChk.selected = false;
				
				floorHeader.label2=floorCombo.selectedItem.label;
				floorHeader.italicFont = false;
				floorHeader.fontSize = 12;
				//задаем итем для проверки что он не нулевой
				var item:String = floorCombo.selectedItem.data;
				
				if (item != "null")
				{
				 //если элемент был не нулевой, грузим xml  из data
					fXML.loadXML(item, onLoadFlorData);
					
				}
				else
				{
					//убиваем все что было во вьювере
					while (PreviewContainer.numChildren > 0) { PreviewContainer.removeChildAt(0) };
					//создаем заново пустую сетку выбиратора
					CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height, false);
					spinviwer.enabled = false;
					spinviwer.value = 0;
				}
				
			}
			//после того как загрузили данные о полах
			function onLoadFlorData():void 
			{
			    f = 0; 
				createFlors(fXML);	
			}
			
			function createFlors(xmldata:XmlParser):void 
			{
				//убиваем все что было во вьювере
				while (PreviewContainer.numChildren > 0) { PreviewContainer.removeChildAt(0) };
				CreateRow(Prewiews, PreviewContainer, 25, 5, 12, thmb_width, thmb_height,false);
				//задаем лист ссылок на изображения
				var ImgList:XMLList = new XMLList();
				ImgList = xmldata.ParserXmlList;
				//запоминаем количество изображений
				var total:int = xmldata.TotalListIndex;
				//создаем массив ссылок на изображения
				var urls:Array = [];
				
				spinviwer.MAX = total;
				
				//если изображений больше 25 то тотал равен 25 врубаем листалки
				if (total > 25) 
				{ total = 25 
				  spinviwer.enabled = true;	
				}
				else
				{
					spinviwer.enabled = false;
				}
				//счетчик
				var cnt:int;
				//количество изображений
				var ttl:int = xmldata.TotalListIndex;;
				for (var i:int = 0; i < total; i++) 
				{
					//счетчик равен сумме элемента из цикла и значение шага спинера
					cnt = i + f;
					//если следущее значение счетчика больше кол-ва изображений делаем счетчик равным меньше на единицу
					// а ссылки на изображения делаем на пустую картинку
					if (cnt+1 > ttl) 
					{ 
						cnt = ttl - 1 
						urls[i] = null;//"images/null.jpg";
					}
					else
					{
						urls[i] = ImgList[cnt].@img;
					}
					
										
					Prewiews[i].value = cnt;
					//если дата нулевая тогда делаем картинку чернобелой
					if (xmldata.ParserXmlList[cnt].@data == null)
					{
						Prewiews[i].filters=[BWfilter]
					}
				}
				//удаляем слушателей
				removeEventListinersFloors(Prewiews, total);
				var pldr:PicLoader = new PicLoader();
				pldr.LoadPictures(urls, Prewiews, total, thmb_width, thmb_height);
				//добавляем слушателей
				addEventListinersFloors(Prewiews, total);
				//spiner.play();
				
				
			}
			
			/**
			 * для обмена картинок местами
			 */
			var temp:MovieClip;
			/**
			 * задаем слушателей на вьюверы
			 * @param	obj-массив объектов которым будут заданы слушатели
			 * @param  col - количество объектов
			 */
			function addEventListinersFloors(obj:Array,col:int):void 
			{
				for (var i:int = 0; i <col ; i++) 
				{
					//определяем слушатели
					obj[i].addEventListener(MouseEvent.CLICK, onClickFloor);
					obj[i].addEventListener(MouseEvent.MOUSE_OVER, onOverFloor);
					obj[i].addEventListener(MouseEvent.MOUSE_OUT, onOutFloor);
					//делаем объекты кнопками
					obj[i].buttonMode = true;
				}
				//задаем среднюю картинку 
				temp = obj[12];
			}
			
			/**
			 * убиваем слушателей на вьюверы
			 * @param	obj-массив объектов у которых будут удалены слушатели
			 * @param  col - количество объектов
			 */
			function removeEventListinersFloors(obj:Array,col:int):void 
			{
				for (var i:int = 0; i <col ; i++) 
				{
					//определяем слушатели
					obj[i].removeEventListener(MouseEvent.CLICK, onClickFloor);
					obj[i].removeEventListener(MouseEvent.MOUSE_OVER, onOverFloor);
					obj[i].removeEventListener(MouseEvent.MOUSE_OUT, onOutFloor);
					//убираем объекты кнопки
					obj[i].buttonMode = false;
				}
			}
			 //mainDataProvider.addItemAt(null, 0);
			 //mainDataProvider.addItemAt(null, 1);
			 //mainDataProvider.addItemAt(null, 2);
			 //mainDataProvider.addItemAt(null, 3);
			
			function onClickFloor(event:MouseEvent):void 
			{
				//temp.scaleX = 1;
				//temp.scaleY = 1;
				
				
				
				//разыминовываем нажатый клип как мувик
				var button:MovieClip = (event.currentTarget as MovieClip);
				//запоминаем значение мувика
				var id:int = button.value;
				trace("button X:", button.x, "button Y:", button.y);
				trace("temp X:", temp.x, "temp Y:", temp.y);
				trace("button.width",button.width, ": button.height", button.height);
				var w:Number = button.width * 0.5;
				var h:Number = button.height * 0.5;
				var bx:Number = button.x;
				var by:Number = button.y;
				var tl:TimelineLite = new TimelineLite({onComplete:onCompletePlay});
				
			
				/*button.addEventListener(MouseEvent.CLICK, onClickFloor);
				button.addEventListener(MouseEvent.MOUSE_OVER, onOverFloor);
				button.addEventListener(MouseEvent.MOUSE_OUT, onOutFloor);
				temp.addEventListener(MouseEvent.CLICK, onClickFloor);
				temp.addEventListener(MouseEvent.MOUSE_OVER, onOverFloor);
				temp.addEventListener(MouseEvent.MOUSE_OUT, onOutFloor);
					//делаем объекты кнопками
				button.buttonMode = true;*/
				//removeEventListinersFloors(Prewiews, 25);
				function onCompletePlay():void 
				{
					//addEventListinersFloors(Prewiews, 25);
				}
					
					tl.insert(TweenLite.to(temp, 0.5, { scaleX:1,scaleY:1,x:166,y:166} ));
					//tl.play();
				//button.scaleX = 2;
				//button.scaleY = 2;
				//button.x = 166-w //- button.width;
				//button.y = 166-h //- button.height ;
				
				// если уже увеличина то уменьшаем, иначе увеличиваем
				if (button.width == 144)
				{
					tl.insert(TweenLite.to(button, 0.5, { scaleX:1, scaleY:1, x:166 , y:166  } )); 
				}
				else
				{
					tl.insert(TweenLite.to(button, 0.5, { scaleX:2,scaleY:2,x:166-w,y:166-h} ));
					//tl.play();
					if(button.x!=temp.x||button.y!=temp.y)
					{
						tl.insert(TweenLite.to(temp, 0.5, {scaleX:1,scaleY:1, x:bx,y:by} ));
						//tl.play();
						temp = button;
					}
				
				}	
				//temp.x = bx;
				//temp.y = by;
				
				//tl.play();	
				
					
					trace(button.width, ":", button.height);				
					PreviewContainer.setChildIndex( button, PreviewContainer.numChildren - 1 ) ; 
				//addEventListinersFloors(Prewiews, 25);
				
				if(changer=="floor")
				{
					FloorDataBack(id);
				}
				else if (changer == "wall")
				{
					WallDataBack(id);
				}
					
			}
			function WallDataBack(id:int):void 
			{
				var datas:String = wXML.ParserXmlList[id].@data;
				var surface:String = wXML.ParserXmlList[id].@surface;
				var material:String = wXML.ParserXmlList[id].@material;
				var price:Number = wXML.ParserXmlList[id].@price;
				var provider:String = wXML.ParserXmlList[id].@provider;
				
				W_id = wXML.ParserXmlList[id].@id;
				
				trace(datas, surface, material, price, provider,W_id);
				
				var objx:Object = mainDataProvider.getItemAt(1);
				objx["Поверхность"] = "Стены";
				objx["Материал"] = material;
				objx["Цена"] = price;
				objx["Поставщик"] = provider;
				var num:Number=new Number(objx["Цена"] * objx["S(площадь)"]);
				objx["Стоимость"] = Number(num.toFixed(2));
				MainDataTable.dataProvider = mainDataProvider;
				
				/*var obj1:Object = new Object();
				obj1 = { "Поверхность":surface, "Материал":material, "Цена":price, "S(площадь)":"", "Стоимость":"", "Поставщик":provider };
				mainDataProvider.removeItemAt(1);
				mainDataProvider.addItemAt(obj1, 1);
				MainDataTable.dataProvider = mainDataProvider;*/
				loadPrewiewPicture();
			}
			
			function FloorDataBack(id:int):void 
			{
				var datas:String = fXML.ParserXmlList[id].@data;
				var surface:String = fXML.ParserXmlList[id].@surface;
				var material:String = fXML.ParserXmlList[id].@material;
				var price:Number = fXML.ParserXmlList[id].@price;
				var provider:String = fXML.ParserXmlList[id].@provider;
				
				trace(datas, surface, material, price, provider);
				
				var objx:Object = mainDataProvider.getItemAt(0);
				objx["Поверхность"] = "Пол";
				objx["Материал"] = material;
				objx["Цена"] = price;
				objx["Поставщик"] = provider;
				var num:Number=new Number(objx["Цена"] * objx["S(площадь)"]);
				objx["Стоимость"] = Number(num.toFixed(2));
				MainDataTable.dataProvider = mainDataProvider;
				
				/*var obj1:Object = new Object();
				obj1 = { "Поверхность":surface, "Материал":material, "Цена":price, "S(площадь)":"", "Стоимость":"", "Поставщик":provider };
				mainDataProvider.removeItemAt(0);
				mainDataProvider.addItemAt(obj1, 0);
				MainDataTable.dataProvider = mainDataProvider;*/
			}
			
			
			function onOverFloor(event:MouseEvent):void 
			{
				//разыминовываем нажатый клип как мувик
				var button:MovieClip = (event.currentTarget as MovieClip);
				//запоминаем значение мувика
				var id:int = button.value;
				//trace("OverID=", id);
				var tl:TimelineLite = new TimelineLite();
				//tl.append(TweenLite.to(button, 0.5, { scaleX:1.1,scaleY:1.1} ));
				tl.append(TweenLite.to(button, 0.5, { alpha:0.5} ));
				tl.play();
			}
			function onOutFloor(event:MouseEvent):void 
			{
				//разыминовываем нажатый клип как мувик
				var button:MovieClip = (event.currentTarget as MovieClip);
				//запоминаем значение мувика
				var id:int = button.value;
				//trace("OutID=", id);
				var tl:TimelineLite = new TimelineLite();
				//tl.append(TweenLite.to(button, 0.5, { scaleX:1,scaleY:1} ));
				tl.append(TweenLite.to(button, 0.5, { alpha:1} ));
				tl.play();
				
			}
			
			
			//===========================================================================
			
			
			
		}//end private function init
		
	}
	
}