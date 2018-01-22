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
			
			//������ �����
			var dtgrd:DataGrid = new DataGrid();
			dtgrd.setSize(600, 85);
			dtgrd.columns = ["�����������", "��������", "����", "S(�������)", "���������", "���������"];
			dtgrd.x = 40;
			dtgrd.y = 550;
			dtgrd.sortableColumns = false;
			
			var dp:DataProvider = new DataProvider();
			dp.addItem({�����������:"���", ��������:"������", ����:"100", "S(�������)":"200",���������:"����"});
			dp.addItem( { �����������:"�����", ��������:"������", ����:"100", "S(�������)":"200", ���������:"����" } );
			dp.addItem( { �����������:"�������", ��������:"������", ����:"100", "S(�������)":"200", ���������:"����" } );
						
			dtgrd.dataProvider = dp;
			
			
			addChild(dtgrd);
			
			


			
			function onLoadComplete():void 
			{
				//var dt:DataProvider = new DataProvider([ { label:"", data:"nihuya" },{ label:"�����", data:"HUETA" } , { label:"������", data:"PIZDOS" } ]); 
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
			