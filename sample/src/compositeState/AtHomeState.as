package compositeState 
{
	import entity.Miner;
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class AtHomeState extends BaseHSMState
	{
		public function AtHomeState(entity:Object, name:String) 
		{
			super(entity, name);	
		}		
		
		override public function update():void
		{
			super.update();
			
			trace("Bob: Home sweet home");
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