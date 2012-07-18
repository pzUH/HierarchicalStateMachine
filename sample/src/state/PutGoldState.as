package state 
{
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	import entity.Miner;
	
	public class PutGoldState extends BaseHSMState
	{
		public function PutGoldState(entity:Object, name:String) 
		{
			super(entity, name);	
		}	
		
		override public function update():void
		{
			trace("Bob: Putting tha gold chunk");
			
			var prob:int = Math.ceil(Math.random() * 5);
			
			if (prob == 1)
			{
				myEntity.changeState(Miner.SMASH_ROCK_STATE);
			}
		}
		
		override public function enter():void
		{
			trace("Bob: Finally I found a gold chunk");
		}
		
		override public function exit():void
		{
			trace("Bob: No gold anymore");
		}
	}
}