package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ziplex
	 */
	public class Radiobox  extends Sprite 
	{
		private var _width:Number=10;
		private var _height:Number = 10;
		private var _selected:Boolean = false;
		private var _color:uint = 0xFFFFFF;
		private var _obj:Sprite = new Sprite();
		private var _label:String = "";
		private var _txtField:TextField = new TextField();
		/**
		 * создает новый бокс
		 */
		public function Radiobox ():void
		{
			drawBox();
			createText();
			this.addChild(_obj);
			this.addChild(_txtField);
		}
		private function createText():void
		{
			
			_txtField.text = _label;
			_txtField.selectable = false;
			_txtField.x = _obj.x+_obj.width;
			_txtField.y =- _obj.height/2;
		}
		private function drawBox():void
		{
			if (_selected)
			{
				_obj.graphics.clear();
				_obj.graphics.lineStyle(1, 0x000000, 1);
				_obj.graphics.beginFill(_color, 1);
				_obj.graphics.drawRect(0, 0, _width, _height);
				_obj.graphics.endFill();
			}
			else
			{
				_obj.graphics.clear();
				_obj.graphics.lineStyle(1, 0x000000, 1);
				_obj.graphics.beginFill(0xFFFFFF, 1);
				_obj.graphics.drawRect(0, 0, _width, _height);
				_obj.graphics.endFill();
			}
		}
		/**
		 *  подпись к боксу
		 */
		public function set label(value:String):void
		{
			_label = value
			createText();
		}
		public function get label():String
		{
			return _label;
		}
		/**
		 *  устанавливаем цвет заливки при включении
		 */
		public function set colorBox(value:uint):void 
		{
			_color = value;
		}
		/**
		 * возвращает цвет заливки
		 */
		public function get colorBox():uint
		{
			return _color;
		}
		/**
		 *  задает ширину бокса
		 */
		public function set Width(value:Number):void
		{
			_width = value;
			drawBox();
		}
		/**
		 * возвращает ширину бокса
		 */
		public function get Width():Number
		{
			return _width;
		}
		
		/**
		 *  задает высоту бокса
		 */
		public function set Height(value:Number):void
		{
			_height = value;
			drawBox();
		}
		/**
		 * возвращает ширину бокса
		 */
		public function get Height():Number
		{
			return _height;
		}
		/**
		 *  задает выбран бокс или нет
		 */
		public function set select (value:Boolean):void
		{
			_selected = value;
			drawBox();
		}
		/**
		 *  возвращает значение выбран бокс в данный момент или нет 
		 */
		public function get select ():Boolean
		{
			return _selected; 
		}
		
		
	}
	
}