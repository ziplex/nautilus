package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.filters.BevelFilter;
	/**
	 * ...
	 * @author ziplex
	 */
	public class  ComboHeader extends Sprite	
	{
		/**
		 * текст заголовока
		 */
		private var _label:String = "";
		/**
		 * текст подсказки
		 */
		private var _label2:String = "";
		/**
		 * ширина хедера
		 */
		private var _width:Number = 100;
		/**
		 * высота хедера
		 */
		private var _height:Number = 40;
		/**
		 * объект в который все пихаем
		 */
		private var obj:Sprite = new Sprite();
		/**
		 *  заголовок
		 */
		private	var _header:TextField = new TextField();
		/**
		 *  подсказка
		 */
		private var _prompt:TextField = new TextField();
		/**
		 * размер шрифта подсказки
		 */
		private var _fontSize:int = 10;
		/**
		 * установка курсива подсказки
		 */
		private var _italic:Boolean = true;
		/**
		 * устанавливает выбран ли объект 
		 */
		private var _selected:Boolean = false;
		/**
		 * изменение при наведениии мыши
		 */
		private var _over:Boolean = false;
		/**
		 * фильтр свечения
		 */
		private var _glowFilter:BevelFilter = new BevelFilter(4, 55, 0xFFFF80,1,0xF4F400,1,50,50);
		/**
		 *  создает новую подсказку
		 */
		public function ComboHeader():void
		{
			
			setlabel();
			setlabel2();
			drawObj();
			
			
			obj.addChild(_header)
			obj.addChild(_prompt);
			this.addChild(obj);
			obj.addEventListener(MouseEvent.MOUSE_OVER, onObjOver);
			obj.addEventListener(MouseEvent.MOUSE_OUT, onObjOut);
			
		}//end _headerLabel
		
		private function onObjOver(event:MouseEvent):void 
		{
			changeObjState();
			obj.filters = [_glowFilter];
		}
		private function onObjOut(event:MouseEvent):void 
		{
			changeObjState();
			obj.filters = null;
		}
		
		private function changeObjState():void
		{
			_over = !_over;
			setlabel();
			setlabel2();
			drawObj();
		}
		
		private function setlabel():void
		{
			var TxtFormat:TextFormat = new TextFormat();
			TxtFormat.bold = true;
			
			_header.text = _label;
			_header.selectable = false;
			_header.wordWrap = true;
			_header.width = _width - 10;
			_header.height = _height - 10;
			_header.x = 5;
			_header.y = 2.5;
			//_header.border = true;
			_header.setTextFormat(TxtFormat);
		}
		
		private function setlabel2():void
		{
			var TxtFormat:TextFormat = new TextFormat();
			//TxtFormat.bold = true;
			TxtFormat.italic = _italic;
			TxtFormat.size = _fontSize;
			_prompt.text = _label2;
			_prompt.selectable = false;
			_prompt.wordWrap = true;
			_prompt.width = _width - 10;
			_prompt.height = _height - 10;
			_prompt.x = 5;
			_prompt.y = _height*0.5;
			//_prompt.border = true;
			_prompt.setTextFormat(TxtFormat);
		}
		
		private function drawObj():void
		{
			obj.graphics.clear();
			obj.graphics.lineStyle(1, 0xE0E0E0, 1);
			if(_selected)
			{
				obj.graphics.beginFill(0xFFFAE2, 1);
			}
			else if (_over)
			{
				obj.graphics.beginFill(0xFFF1AE, 1);
			}
			else 
			{
				obj.graphics.beginFill(0xFFFFFF, 1);
			}
			obj.graphics.drawRect(0, 0, _width, _height);
			obj.graphics.endFill();
			obj.graphics.moveTo(10, _height * 0.5);
			obj.graphics.lineTo(_width - 10, _height * 0.5);
		}
		
		/**
		 * заголовок 
		 */
		public  function set label(value:String):void
		{
			_label = value;
			setlabel();
			drawObj();
		}
		public  function get label():String
		{
			return _label;
		}
		
		/**
		 * подсказка
		 */
		public  function set label2(value:String):void
		{
			_label2 = value;
			setlabel2();
			drawObj();
		}
		public  function get label2():String
		{
			return _label2;
		}
		
				
		
		//размер шрифта для подсказки
		public  function set fontSize(value:int):void
		{
			_fontSize = value;
			setlabel2();
			drawObj();
		}
		public  function get fontSize():int
		{
			return _fontSize;
		}
		//указываем курсив
		public  function set italicFont(value:Boolean):void
		{
			_italic = value;
			setlabel2();
			drawObj();
		}
		public  function get italicFont():Boolean
		{
			return _italic;
		}
		
		//указываем выбран ли объект
		public  function set selected(value:Boolean):void
		{
			_selected = value;
			setlabel();
			setlabel2();
			drawObj();
		}
		public  function get selected():Boolean
		{
			return _selected;
		}
		
		
		
		public  function set Width(value:Number):void
		{
			_width = value;
			setlabel();
			setlabel2();
			drawObj();
		}
		public  function get Width():Number
		{
			return _width
		}
		
		public  function set Height(value:Number):void
		{
			_height = value;
			setlabel();
			setlabel2();
			drawObj();
		}
		public  function get Height():Number
		{
			return _height;
		}
		
	}//end class
	
	}//end package