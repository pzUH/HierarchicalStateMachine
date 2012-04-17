package state 
{
	import com.pzuh.ai.hierarchicalstatemachine.BaseHSMState;
	
	import entity.Miner;
	
	public class WatchTVState extends BaseHSMState
	{
		public function WatchTVState (entity:Object) 
		{
			super(entity);
		}	
		
		override public function update():void
		{
			trace("Bob: Watching tha TV");
			
			var prob:int = Math.ceil(Math.random() * 15);
			
			if (prob == 1)
			{
				myEntity.changeState(Miner.SLEEP_STATE);
			}
		}
		
		override public function enter():void
		{
			trace("Bob: turn on tha TV");
		}
		
		override public function exit():void
		{
			trace("Bob: turn off tha TV");
		}
	}
}