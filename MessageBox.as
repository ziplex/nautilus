package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author ziplex
	 */
	public class  MessageBox extends Sprite
	{
		/**
		 * основной объект
		 */
		private var _obj:Sprite = new Sprite();
		/**
		 * предыдущая кнопка
		 */
		private var _nextButton:Sprite = new Sprite();
		/**
		 * следующая кнопка
		 */
		private var _prevButton:Sprite = new Sprite();
		/**
		 * подпись к следующей кнопке
		 */
		private var _nextText:TextField = new TextField();
		/**
		 * подпись к предыдущей кнопке
		 */
		private var _prevText:TextField = new TextField();
		/**
		 * событие нажатия следующей кнопки
		 */
		private var _nextEvnt:Event = new Event("ClickNext");
		/**
		 * событие нажатия предыдущей кнопки
		 */
		
		private var _prevEvnt:Event = new Event("ClickPrev");
		/**
		 * ширина бокса
		 */
		private var _width:Number = 440;
		/**
		 * высота бокса
		 */
		private var _height:Number = 380;
		/**
		 * основной текст
		 */
		private var _mainText:TextField = new TextField();
		/**
		 * изображение
		 */
		private var _picture:PicLoader = new PicLoader();
		/**
		 * контейнер с изображением
		 */
		private var _picContainer:Sprite = new Sprite();
		/**
		 * фильтр тень
		 */
		private var _shadowFilter:DropShadowFilter = new DropShadowFilter(10, 45, 0x000000, 0.7, 15, 15, 1, 1);
		/**
		 * фильтр свечения
		 */
		private var _glowFilter:GlowFilter = new GlowFilter(0xFFFA1C, 0.7);
		/**
		 * ссылка на изображение
		 */
		private var _url:String;
		/**
		 * основной контейнер
		 */
		private var _mainContainer:Sprite = new Sprite();
		/**
		 * ширина основного контейнера
		 */
		private var _mainWidth:Number = 1200;
		/**
		 * высота основного контейнера
		 */
		private var _mainHeight:Number = 700;
		/**
		 * основная ф-ция 
		 */
		public function MessageBox ():void
		{
			createMsgBox();
			
			_prevButton.addChild(_prevText);
			_nextButton.addChild(_nextText);
			_picContainer.addChild(_picture);
			_obj.addChild(_mainText);
			_obj.addChild(_picContainer);
			_obj.addChild(_prevButton);
			_obj.addChild(_nextButton);
			_obj.filters = [_shadowFilter];
			_mainContainer.addChild(_obj);
			this.addChild(_mainContainer);
			
			_prevButton.addEventListener(MouseEvent.CLICK, onPrevClick);
			_prevButton.addEventListener(MouseEvent.MOUSE_OVER, onPrevOver);
			_prevButton.addEventListener(MouseEvent.MOUSE_OUT, onPrevOut);
			
			_nextButton.addEventListener(MouseEvent.CLICK, onNextClick);
			_nextButton.addEventListener(MouseEvent.MOUSE_OVER, onNextOver);
			_nextButton.addEventListener(MouseEvent.MOUSE_OUT, onNextOut);
			
			
		}//end public function MessageBox
		
		
		private function onPrevClick (event:MouseEvent):void
		{
			dispatchEvent(_prevEvnt);
		}
		private function onPrevOver (event:MouseEvent):void
		{
			_prevButton.filters = [_glowFilter];
		}
		private function onPrevOut (event:MouseEvent):void
		{
			_prevButton.filters = null;
		}
		
		private function onNextClick (event:MouseEvent):void
		{
			dispatchEvent(_nextEvnt);
		}
		
		private function onNextOver (event:MouseEvent):void
		{
			_nextButton.filters = [_glowFilter];
		}
		
		private function onNextOut (event:MouseEvent):void
		{
			_nextButton.filters = null;
		}
		
		/**
		 * ссылка на изображение
		 */
		public function set url(value:String):void
		{
			_url = value;
			loadImage();
		}
		/**
		 * загрузка изображения
		 */
		private function loadImage():void
		{
			_picture.LoadPic(_url, _picContainer.width, _picContainer.height,"linear",null,_picContainer);
		}
		private function createMsgBox():void
		{
			_mainContainer.graphics.clear();
			_mainContainer.graphics.beginFill(0xFFFFFF, 0.6);
			_mainContainer.graphics.drawRect(0, 0, _mainWidth, _mainHeight);
			_mainContainer.graphics.endFill();
			
			_obj.graphics.clear();
			_obj.graphics.lineStyle(1, 0x000000, 1);
			_obj.graphics.beginFill(0x6C3600, 1);
			_obj.graphics.drawRect(0, 0, _width, _height);
			_obj.graphics.endFill();
			
			
			var formattxt:TextFormat = new TextFormat();
			formattxt.color = 0xFFFFFF;
			formattxt.size = 14;
			formattxt.font = "Arial";
			formattxt.bold = true;
			formattxt.align = TextFormatAlign.CENTER;
			
			_mainText.width = _width;
			_mainText.height = 200;
			_mainText.wordWrap = true;
			_mainText.text = "В данной версии программы ДизайнеR реализована возможность работать исключительно с данным интерьером";
			_mainText.selectable = false;
			_mainText.setTextFormat(formattxt);
			_mainText.x = _width *0.5-_mainText.width*0.5;
			_mainText.y = 40;
			
			
			_picContainer.graphics.clear();
			_picContainer.graphics.lineStyle(1, 0x000000, 1);
			_picContainer .graphics.drawRect(0, 0, _width-70, _height * 0.5);
			_picContainer.graphics.endFill();
			_picContainer.x = _mainText.x + 35;
			_picContainer.y = _mainText.y +80;
			
			var btnFormat:TextFormat = new TextFormat();
			btnFormat.color = "0xFFFFFF";
			btnFormat.size = 16;
			btnFormat.underline = true;
			btnFormat.font = "Arial";
			btnFormat.bold = true;
			btnFormat.align = TextFormatAlign.LEFT;
			
			_prevText.autoSize = TextFieldAutoSize.LEFT;
			_prevText.text = "Назад";
			_prevText.selectable = false;
			_prevText.setTextFormat(btnFormat);
			
			_prevButton.x = _picContainer.x;
			_prevButton.y = _picContainer.y + _picContainer.height;
			_prevButton.buttonMode = true;
			
			_nextText.autoSize = TextFieldAutoSize.LEFT;
			_nextText.text = "Продолжить";
			_nextText.selectable = false;
			_nextText.setTextFormat(btnFormat);
			
			_nextButton.x = _picContainer.x + _picContainer.width - _nextText.width;
			_nextButton.y = _picContainer.y + _picContainer.height;
			_nextButton.buttonMode = true;
			
			
			_obj.x = _mainWidth * 0.5-_obj.width*0.5;
			_obj.y = _mainHeight * 0.5-_obj.height*0.5;
			
		}//end function createMsgBox
		
	}//end public class
	
	}//end package