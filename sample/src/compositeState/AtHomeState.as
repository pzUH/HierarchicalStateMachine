package compositeState 
{
	import entity.Miner;
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class AtHomeState extends BaseHSMState
	{
		public function AtHomeState(entity:Object, initState:BaseHSMState = null) 
		{
			super(entity,initState);	
		}		
		
		override public function update():void
		{
			trace("Bob: Home sweet home");
			
			var prob:int = Math.ceil(Math.random() * 5);
			
			if (prob == 1)
			{
				myEntity.changeState(Miner.AT_MINE_STATE);
			}
		}
		
		override public function enter():void
		{
			trace("Bob: Entering mah home");
		}
		
		override public function exit():void
		{
			trace("Bob: Leavin' mah tiny old shack");
		}
	}
}