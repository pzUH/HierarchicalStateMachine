package state 
{
	import entity.Miner;	
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class SmashRockState extends BaseHSMState
	{
		public function SmashRockState(entity:Object, name:String) 
		{
			super(entity, name);	
		}	
		
		override public function update():void
		{
			trace("Bob: Smashing, smashing, smashing");
			
			var prob:int = Math.ceil(Math.random() * 5);
			
			if (prob == 1)
			{
				myEntity.changeState(Miner.PUT_GOLD_STATE);
			}
		}
		
		override public function enter():void
		{
			trace("Bob: Start smashing tha stone");
		}
		
		override public function exit():void
		{
			trace("Bob: Stop smashing");
		}
	}
}