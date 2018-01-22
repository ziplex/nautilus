package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author ziplex
	 */
	public class  PromptLabel extends Sprite	
	{
		private var _label:String = "";
		private var _width:Number = 300;
		private var _height:Number = 100;
		private var obj:Sprite = new Sprite();
		private	var prompt:TextField = new TextField();
			
		/**
		 *  создает новую подсказку
		 */
		public function PromptLabel():void
		{
			
			setlabel();
			drawObj();
			
			
			obj.addChild(prompt)
			this.addChild(obj);
			
		}//end promptLabel
		private function setlabel():void
		{
			var TxtFormat:TextFormat = new TextFormat();
			//TxtFormat.bold = true;
			
			prompt.text = _label;
			prompt.autoSize = TextFieldAutoSize.LEFT;
			prompt.selectable = false;
			prompt.wordWrap = true;
			prompt.width = _width - 10;
			prompt.height = _height - 10;
			prompt.x = 5;
			prompt.y = 2.5;
			//prompt.border = true;
			prompt.setTextFormat(TxtFormat);
		}
		private function drawObj():void
		{
			obj.graphics.clear();
			obj.graphics.lineStyle(1, 0xE0E0E0, 1);
			obj.graphics.beginFill(0xFFFAE2, 1);
			obj.graphics.drawRect(0, 0, _width, _height);
			obj.graphics.endFill();
		}
		
		
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
		public  function set Width(value:Number):void
		{
			_width = value;
			setlabel();
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
			drawObj();
		}
		public  function get Height():Number
		{
			return _height;
		}
		
	}//end class
	
	}//end package