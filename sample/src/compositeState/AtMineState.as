package compositeState 
{
	import entity.Miner;
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class AtMineState extends BaseHSMState
	{		
		public function AtMineState(entity:Object, initState:BaseHSMState = null) 
		{
			super(entity,initState);				
		}	
		
		override public function update():void
		{
			trace("Bob: Mining, mining, mining");
			
			var prob:int = Math.ceil(Math.random() * 15);
			
			if (prob == 1)
			{
				myEntity.changeState(Miner.AT_HOME_STATE);
			}
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