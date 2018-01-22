package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.GlowFilter;
	import com.greensock.*;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author ziplex
	 */
	public class  MainPage extends Sprite
	{
		private var _obj:Sprite = new Sprite();
		 
		
		public function MainPage():void
		{
		   createObj();
		   this.addChild(_obj);
		}
		
		private function createObj():void
		{
			var wdth:Number = 1200;
			var hght:Number = 700;
			
			_obj.graphics.clear();
			_obj.graphics.lineStyle(1, 0xF4F4F4, 1);
			_obj.graphics.beginFill(0xFFFFFF, 1);
			_obj.graphics.drawRect(0, 0, wdth, hght);
			_obj.graphics.endFill();
			
			var copiright:TextField = new TextField();
			copiright.selectable = false;
			copiright.textColor = 0x969696;
			copiright.autoSize = TextFieldAutoSize.LEFT;
			copiright.text = "© 2009-2010 Студия Nautilus";
			copiright.x = 25;
			copiright.y = 640;
			_obj.addChild(copiright);
			
			var logotxt:TextField = new TextField();
			var logoFormat:TextFormat = new TextFormat();
			
			logoFormat.size = 26;
			logoFormat.color=0x969696;
			
			logotxt.selectable = false;
			logotxt.autoSize = TextFieldAutoSize.LEFT;
			logotxt.text = "ДизайнеR (демо v1.0)";
			logotxt.setTextFormat(logoFormat);
					
			logoFormat.size = 26;
			logoFormat.color=0xFF00FF;		
			logotxt.setTextFormat(logoFormat, 7, 8);
			
			logoFormat.size = 16;
			logoFormat.color=0x969696;		
			logotxt.setTextFormat(logoFormat, 9, 20);
			
			logotxt.x = wdth*0.5 -logotxt.width*0.5;
			logotxt.y = hght * 0.5-logotxt.height*0.5;
			
			_obj.addChild(logotxt);
			
			
			logotxt.addEventListener(MouseEvent.CLICK, onLogoClick);
			logotxt.addEventListener(MouseEvent.ROLL_OVER, onLogoOver);
			logotxt.addEventListener(MouseEvent.ROLL_OUT, onLogoOut);
			
			var glFltr:GlowFilter = new GlowFilter(0xFF00FF, 0.5, 80, 80);
			
			function onLogoOver(event:MouseEvent):void 
			{
				logotxt.filters = [glFltr];
			}
			function onLogoOut(event:MouseEvent):void 
			{
				logotxt.filters = null;
			}
		}
		private function onLogoClick(event:MouseEvent):void
		{
			var tl:TimelineLite = new TimelineLite({onComplete:onCompletePlay});
				tl.append(TweenLite.to(_obj, 0.5, { y:1000} ));
				tl.play();
			
				function onCompletePlay():void 
				{
				  removeChild(_obj);	
				}
				
		}
		
	}//end MainPageClass
	
	}//end package 