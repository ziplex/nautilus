package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ziplex
	 */
	public class SpinClicker extends Sprite 
	{
		/**
		 * шаг счетчика
		 */
		private var _step:int=9;
		/**
		 * максимальное число до которого считать
		 */
		private var _total:int=30;
		/**
		 * объект счетчика
		 */
		private var _obj:Sprite = new Sprite();
		/**
		 * значение счетчика
		 */
		private var _value:int=0;
		/**
		 *  состояние счетчика
		 */
		private var _enable:Boolean=false;
		/**
		 * расстояние между кнопками
		 */
		private var _distance:Number=10;
		/**
		 * левая стрелка
		 */
		private var _leftArrow:Sprite = new Sprite();
		/**
		 * правая стрелка
		 */
		private	var _rightArrow:Sprite = new Sprite();
		/**
		 * событие нажатия влево
		 */
		private var ChangeLeft:Event = new Event("ChangeLeft");
		/**
		 * событие нажатия вправо
		 */
		private var ChangeRight:Event = new Event("ChangeRight");
		/**
		 *  событие нажатия любой из клавиш
		 */
		private var ChangeSpin:Event = new Event("ChangeSpin");
		/**
		 * размер стрелок
		 */
		private var _size:Number = 10;
		/**
		 * показывать линию между стрелками
		 */
		private var _showLine:Boolean = true;
		
		public function SpinClicker():void
		{
			_obj.addChild(_leftArrow);
			_obj.addChild(_rightArrow);
			this.addChild(_obj);
			_obj.x = 20;
			createSpin();
			_leftArrow.buttonMode = true;
			_rightArrow.buttonMode = true;
			
			_leftArrow.addEventListener(MouseEvent.CLICK, leftClick);
			_rightArrow.addEventListener(MouseEvent.CLICK, rightClick);
			
			enableButton();
		}
		
		private function leftClick(event:MouseEvent):void
		{
			_value-= _step;
			if (_value < 0)
			{
				_value = 0 
				
			}
			trace(_value);
			dispatchEvent(ChangeLeft);
			dispatchEvent(ChangeSpin);
		}
		private function rightClick(event:MouseEvent):void
		{
			_value += _step;
			if (_value > _total)
			{
			  _value = 0;
			}
			trace(_value);
			dispatchEvent(ChangeRight);
			dispatchEvent(ChangeSpin);
		}
		
		/**
		 * создаем счетчик
		 */
		private function createSpin():void
		{
			//рисуем левую стрелку
			_leftArrow.graphics.clear();
			_leftArrow.graphics.lineStyle(1, 0x000000, 1);
			_leftArrow.graphics.beginFill(0x000000, 1);
			_leftArrow.graphics.lineTo( -_size, _size*0.5);
			_leftArrow.graphics.lineTo(0, _size);
			_leftArrow.graphics.lineTo(0, 0);
			_leftArrow.graphics.endFill();
			
			//рисуем правую стрелку
			_rightArrow.graphics.clear();
			_rightArrow.graphics.lineStyle(1, 0x000000, 1);
			_rightArrow.graphics.beginFill(0x000000, 1);
			_rightArrow.graphics.lineTo( _size, _size*0.5);
			_rightArrow.graphics.lineTo(0, _size);
			_rightArrow.graphics.lineTo(0, 0);
			_rightArrow.graphics.endFill();
			
			_rightArrow.x = _distance;
			
			if (_showLine)
			{
				_leftArrow.graphics.moveTo(0, _size *0.5);
				_leftArrow.graphics.lineTo(_distance,_size *0.5)
			}
			
		}
		/**
		 * показывает линию между стрелками
		 */
		public function set showline(value:Boolean):void
		{
			_showLine = value;
			createSpin();
		}
		/**
		 * размер кнопок
		 */
		public function set size(value:Number):void
		{
			_size = value;
			createSpin();
		}
		/**
		 *  устанавливает расстояние между стрелками
		 */
		public function set distance(value:Number):void
		{
			_distance = value;
			createSpin();
		}
		/**
		 *  активность объекта
		 */
		public function set enabled(value:Boolean):void
		{
			_enable = value;
			enableButton();
			
		}
		// устанавливает активность кнопок
		private function enableButton():void
		{
			if (_enable)
			{
				_leftArrow.mouseEnabled = true;
				_rightArrow.mouseEnabled = true;
				_leftArrow.alpha = 1;
				_rightArrow.alpha = 1;
			}
			else
			{
				_leftArrow.mouseEnabled = false;
				_rightArrow.mouseEnabled = false;
				_leftArrow.alpha = 0.4;
				_rightArrow.alpha = 0.4;
			}
		}
		/**
		 * останавливаем счетчик
		 */
		public function stop():void
		{
			_leftArrow.removeEventListener(MouseEvent.CLICK, leftClick);
			_rightArrow.removeEventListener(MouseEvent.CLICK, rightClick);
		}
		/**
		 * возобнавляем счетчик
		 */
		public function play():void
		{
			_leftArrow.addEventListener(MouseEvent.CLICK, leftClick);
			_rightArrow.addEventListener(MouseEvent.CLICK, rightClick);
		}
		/**
		 * возвращает значение
		 */
		public  function get value():int
		{
			return _value;
		}
		public function set value(value:int):void
		{
			_value = value;
		}
		/**
		 * устанавливает максимальное значение
		 */
		public function set MAX(value:int):void
		{
			_total = value;
		}
		public function get MAX():int
		{
			return _total;
		}
		/**
		 * устанавливает шаг 
		 */
		public function set step(value:int):void
		{
			_step = value;
		}
		public function get step():int
		{
			return _step;
		}
		
	}
	
}