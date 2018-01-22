package 
{
	import flash.display.Sprite;
	import flash.display.*;
	import flash.display.DisplayObjectContainer;
	import flash.events.*;
	import flash.net.* 
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import silin.utils.Preloader;
	import com.greensock.*;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author ziplex
	 */
	public class PicLoader extends Sprite 
	{
		/**
		 * загружаем одно изображение
		 * @param	url ссылка на изображение
		 * @param	width ширина изображения после загрузки
		 * @param	height высота изображения после загрузки
		 * @param   PreloaderType тип прелоадера circle - круговой, по умолчанию linear - линейный 
		 * @param   func - вызываем по завершению загрузки, по умолчанию null
		 */
		public function LoadPic(url:String,width:Number,height:Number,PreloaderType:String="linear",func:Function=null,preloadContain:Sprite=null):void 
		{
			var timelinePreloader:TimelineLite = new TimelineLite( { onReverseComplete:onPreloadComplete } );
			//вызываем когда загрузка закончилась
			function onPreloadComplete():void 
			{
				preloadContain.removeChild(preload);
			}
			// если тип линейный рисуем линию если круговой рисуем круговой прелоадер
			if (PreloaderType == "linear")
			{
				/**
				*  полоска прелоадера
				*/
				var preload:Sprite = new Sprite();
				preload.graphics.beginFill(0x000000, 0.8);
				preload.graphics.drawRect(0, 0, width, 15);
				preload.graphics.endFill();
				preloadContain.addChild(preload);
				preload.x = 13;
				preload.y = 741;
				preload.alpha = 0;
				timelinePreloader.append(TweenLite.to(preload, 1, { alpha:1 } ) );
				timelinePreloader.stop();
			/**
			 * храним смещение по ширине 
			 */
				var vx:Number = width / 100;
				preload.scaleX = 0;
			}
			if (PreloaderType == "circle")
			{
				var CirclePreload:Preloader = new Preloader (25, 0x80FF00, 1, 60);
				CirclePreload.x = width / 2;
	            CirclePreload.y = height / 2;
				addChild(CirclePreload);
				
			}
			
			
			
			var loader:Loader = new Loader();
			//добавляем слушателей лоадеру
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoadInit);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, thmbIOerror);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.VERIFY_ERROR, thmbVeryfyIOerror);	
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, thmbNetworkerror);
			
			//берем путь к картинке из url 
			var pic_url:URLRequest = new URLRequest(url);
			//грузим картинку	
			loader.load(pic_url);
			
			function onLoadInit(event:Event):void 
			{
			//если переданый объект не пустой грузим его , иначе вываливаем ошибку в алерт
			if (loader.content != null)
			{
				//убиваем прелоадер
				if (PreloaderType == "linear")
				{
				  timelinePreloader.reverse();
				  //preloadContain.removeChild(preload);
				}
				if (PreloaderType == "circle")
				{
				 removeChild(CirclePreload);
				}
				
				
				addChild(loader.content);
				loader.content.width = width;
				loader.content.height = height;
				//грохаем листенеры 
				loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoadInit);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, thmbIOerror);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.VERIFY_ERROR, thmbVeryfyIOerror);	
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, thmbNetworkerror);
				if (func!=null)
				{
				 func();
				} 
			}
			else
			{
			 //trace("Ошибка загрузки изображения");
			}
		
			}//end function OnLoadInit
			
			function onLoadProgress(evt:ProgressEvent):void 
			{
				
				if (PreloaderType == "linear")
				{
				 
				timelinePreloader.play();
				 var cntload:int;
				 cntload = Math.round(100 * (evt.bytesLoaded / evt.bytesTotal));
				 var v:Number = cntload * 0.01;
				 preload.scaleX = v;
				}
				//scaleLoad(preload, v);
				//trace("загружено",cntload)
			}
										
			function thmbNetworkerror(event:Event):void
			{
			  	//trace("thmbIOerror", event);
			}	
			function thmbIOerror(event:Event):void
			{
				//trace("thmbIOerror", event);
			}
			
			function thmbVeryfyIOerror(event:Event):void
			{
				//trace("thmbVerifyError", event);
			}
			
			
			
		}//end public function LoadPic
		/**
		 * загрузка множества изображений
		 * @param	urls массив ссылок на изображения
		 * @param	pics массив в который загрузим изображения
		 * @param	Total количество загружаемых изображений
		 * @param	width ширина загруженного битмапа
		 * @param	height высота загруженного битмапа
		 * @param	removeObj - используется для удаления прелоадера после загрузки каждого изображения
		 * @param	remove - указывает есть ли прелоадер который нужно удалить после загрузки
		 * @param   frame - рисовать рамку по умолчанию да
		 */
		public function LoadPictures(urls:Array,pics:Array,Total:int,width:Number,height:Number,removeObj:DisplayObject=null,remove:Boolean=false,frame:Boolean=true):void 
		{
			
			/**
			 *  полоски прелоадера
			 */
			var preload:Array = [];
			
			
			for (var i:int = 0; i < Total; i++) 
			{
				preload[i] = new Sprite();
				preload[i].graphics.beginFill(0xFFFFFF, 1);
			    preload[i].graphics.drawRect(0,0, width,height);
			    preload[i].graphics.endFill();
				preload[i].scaleX = 0;
				pics[i].addChild(preload[i]);
				
				/*preload[i] = new Preloader (25, 0x80FF00, 1, 60);
				preload[i].x = width / 2;
	            preload[i].y = height / 2;
				pics[i].addChild(preload[i]);*/
			}
			//идентификатор для указания на номер загружаемого контента
			var id:int = 0;
			//создаем лоадер
			var loader:Loader = new Loader();
			//добавляем слушателей лоадеру
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoadInit);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, thmbIOerror);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.VERIFY_ERROR, thmbVeryfyIOerror);	
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, thmbNetworkerror);
			
			//берем путь к картинке из массива urls 
			var pic_url:URLRequest = new URLRequest(urls[id]);
			//грузим картинку	
			loader.load(pic_url);
			
			function onLoadInit(event:Event):void 
			{
			 
			//если переданый объект не пустой грузим его в массив, иначе вываливаем ошибку в алерт
			if (loader.content != null)
			{
				//убиваем прелоадер
				pics[id].removeChild(preload[id]);
				//добавляем загруженое в массив
				 pics[id].addChild(loader.content);
				//устанавливаем размеры
				loader.content.width = width;
				loader.content.height = height;
				//если указали рамку рисуем ее
				if (frame)
				{
					var obj:Sprite = new Sprite();
					obj.graphics.lineStyle(1, 0xFFFFFF, 1);
					obj.graphics.drawRect(0, 0, width, height);
					obj.graphics.endFill();
					pics[id].addChild(obj);
				}
				//прибавляем идентификатор на единицу
				id++;
				// если id меньше чем кол-во картинок грузим еще
				if(id<Total)
				{
					//грохаем листенеры 
					loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoadInit);
					loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, thmbIOerror);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.VERIFY_ERROR, thmbVeryfyIOerror);	
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, thmbNetworkerror);
					//лоадеру присваиваем новый лоадер
					loader = new Loader();
					//добавляем слушателей лоадеру
					loader.contentLoaderInfo.addEventListener(Event.INIT, onLoadInit);
					loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, thmbIOerror);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.VERIFY_ERROR, thmbVeryfyIOerror);	
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, thmbNetworkerror);
			
					//берем путь к картинке из массива urls 
					var pic_url2:URLRequest = new URLRequest(urls[id]);
					//грузим картинку если не нулевая, иначе нах.	
					if(urls[id]==null)
					{
						//грохаем листенеры 
						loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoadInit);
						loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
						loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, thmbIOerror);
						loader.contentLoaderInfo.removeEventListener(IOErrorEvent.VERIFY_ERROR, thmbVeryfyIOerror);	
						loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, thmbNetworkerror);
						
					}
					else
					{
						loader.load(pic_url2);
					}
				}
				//если количество загруженных равно количеству всех грохаем листенеры лоадера 
				else if (id == Total)
				{
					//грохаем листенеры 
					loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoadInit);
					loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, thmbIOerror);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.VERIFY_ERROR, thmbVeryfyIOerror);	
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, thmbNetworkerror);
				}
			}
			else
			{
			 //trace("Ошибка загрузки изображения");
			}
		
			}//end function OnLoadInit
			
			function onLoadProgress(evt:ProgressEvent):void 
			{
				var cntload:int;
				 cntload = Math.round(100 * (evt.bytesLoaded / evt.bytesTotal));
				 var v:Number = cntload * 0.01;
				 preload[id].scaleX = v;
				//var cntload:int;
				//cntload = Math.round(100 * (evt.bytesLoaded / evt.bytesTotal));
				//scaleLoad(preload, v);
				//trace("загружено",cntload)
			}
										
			function thmbNetworkerror(event:Event):void
			{
			  	//trace("thmbIOerror", event);
			}	
			function thmbIOerror(event:Event):void
			{
				//trace("thmbIOerror", event);
			}
			
			function thmbVeryfyIOerror(event:Event):void
			{
				//trace("thmbVerifyError", event);
			}
		} //end function LoadPictures
	}//end public class
	
	}//end package 