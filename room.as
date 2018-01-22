package 
{
	
	/**
	 * ...
	 * @author ya
	 */
	public class room extends Array 
	{
		private var _data:String;
		private var _item:String;
		private var _test:int;
		private var _sapr:Number;
		
		public function room()
		{}
		public function get data():String
		{
			return _data;
		}
		public function set data(value:String):void
		{
			_data = value;
		}
		
		public function get item():String
		{
			return _item;
		}
		public function set item(value:String):void
		{
			_item = value;
		}
		
		public function get test():int
		{
			return _test;
		}
		public function set test(value:int):void
		{
			_test = value;
		}
		public function get sapr():Number
		{
			return _sapr;
		}
		public function set sapr(value:Number):void
		{
			_sapr = value;
		}
			
	}
	
}