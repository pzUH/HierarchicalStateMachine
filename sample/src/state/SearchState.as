package state 
{
	import entity.Miner;
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class SearchState extends BaseHSMState
	{
		public function SearchState(entity:Object) 
		{
			super(entity);
		}
		
		override public function update():void
		{
			trace("Bob: Searching, searching, searching");
			
			var prob:int = Math.ceil(Math.random() * 5);
			
			if (prob == 1)
			{
				myEntity.changeState(Miner.DIG_STATE);
			}
		}
		
		override public function enter():void
		{
			trace("Bob: Start searching for gold");
		}
		
		override public function exit():void
		{
			trace("Bob: Stop searching");
		}
	}
}