package compositeState 
{
	import entity.Miner;
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class AtMineState extends BaseHSMState
	{		
		public function AtMineState(entity:Object, name:String) 
		{
			super(entity, name);			
		}	
		
		override public function update():void
		{
			super.update();
			
			trace("Bob: Mining, mining, mining");
		}
		
		override public function enter():void
		{
			trace("Bob: Entering this dark mine");
		}
		
		override public function exit():void
		{
			trace("Bob: Finally I can see the sun");
		}
	}
}