//=========================================================================================================
			var obj:Object = new Object();
			var MainCombo:ComboBox = new ComboBox();
			var xml:XmlParser = new XmlParser();
			var txt:TextField = new TextField();
			var sldr:Slider = new Slider();
			sldr.x = 200;
			sldr.y = 30;
			sldr.maximum = 5000;
			sldr.minimum = 50;
			sldr.width = 200;
			txt.x = 200;
			txt.y = 10;
			addChild(txt);
			addChild(sldr)
			xml.loadXML("data.xml", onLoadComplete);
			
			//рисуем сетку
			var dtgrd:DataGrid = new DataGrid();
			dtgrd.setSize(600, 85);
			dtgrd.columns = ["Поверхность", "Материал", "Цена", "S(площадь)", "Стоимость", "Поставщик"];
			dtgrd.x = 40;
			dtgrd.y = 550;
			dtgrd.sortableColumns = false;
			
			var dp:DataProvider = new DataProvider();
			dp.addItem({Поверхность:"Пол", Материал:"Дерево", Цена:"100", "S(площадь)":"200",Стоимость:"Цена"});
			dp.addItem( { Поверхность:"Стены", Материал:"Картон", Цена:"100", "S(площадь)":"200", Стоимость:"Цена" } );
			dp.addItem( { Поверхность:"Потолок", Материал:"Кирпич", Цена:"100", "S(площадь)":"200", Стоимость:"Цена" } );
						
			dtgrd.dataProvider = dp;
			
			
			addChild(dtgrd);
			
			


			
			function onLoadComplete():void 
			{
				//var dt:DataProvider = new DataProvider([ { label:"", data:"nihuya" },{ label:"Хуйня", data:"HUETA" } , { label:"Пиздос", data:"PIZDOS" } ]); 
				var dt:DataProvider = new DataProvider(xml.xmlData);
				MainCombo.move(10, 10);
				MainCombo.width = 100;
				MainCombo.height = 15;
				MainCombo.dataProvider = dt;
				addChild(MainCombo);
				MainCombo.addEventListener(Event.CHANGE, onClick);
				sldr.addEventListener(SliderEvent.CHANGE, changeHandler); 
				
				
 
			}
			function changeHandler(event:SliderEvent):void 
			{ 
				txt.text = event.value + "percent";     
			}

			
			
			function onClick(event:Event):void 
			{
				txt.text = MainCombo.selectedItem.data;
				trace(MainCombo.selectedItem.data);
			}
			