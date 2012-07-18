package state 
{
	import com.pzuh.ai.hierarchicalstatemachine.BaseHSMState;
	
	import entity.Miner;
	
	public class SleepState extends BaseHSMState
	{
		public function SleepState(entity:Object, name:String) 
		{
			super(entity, name);			
		}
		
		override public function update():void
		{
			trace("Bob: ...zzzz....");
			
			var prob:int = Math.ceil(Math.random() * 15);
			
			if (prob == 1)
			{
				myEntity.changeState(Miner.WATCH_TV_STATE);
			}
		}
		
		override public function enter():void
		{
			trace("Bob: It's time to go to bed");
		}
		
		override public function exit():void
		{
			trace("Bob: I'm fully rested");
		}
	}

}