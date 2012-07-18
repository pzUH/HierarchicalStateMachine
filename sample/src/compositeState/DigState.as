package compositeState 
{
	import entity.Miner;
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class DigState extends BaseHSMState
	{
		public function DigState(entity:Object, name:String) 
		{
			super(entity, name);	
		}
		
		override public function update():void
		{
			trace("Bob: Digging, digging, digging");
			
			var prob:int = Math.ceil(Math.random() * 5);
			
			if (prob == 1)
			{
				myEntity.changeState(Miner.SEARCH_STATE);
			}
		}
		
		override public function enter():void
		{
			trace("Bob: Let's start digging");
		}
		
		override public function exit():void
		{
			trace("Bob: Stop digging");
		}
	}
}