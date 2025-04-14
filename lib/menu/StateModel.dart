//* Let's create a state model

class States {
  String? names;

  States({
    this.names,
  });

  void setName(String getName) {
    names = getName;
  }

  String getName() {
    return names!;
  }
}

List<States> allStates() {
  List<States> states = [];
  States statesModel = new States();

  //1
  statesModel.setName("DRYFRUIT KACHORI");
  states.add(statesModel);
  statesModel = new States();

  //2
  statesModel.setName("SWEETS");
  states.add(statesModel);
  statesModel = new States();

  //3
  statesModel.setName("NAMKEENS");

  states.add(statesModel);
  statesModel = new States();

  //4
  statesModel.setName("MILK SHAKES MIX");

  states.add(statesModel);
  statesModel = new States();

  //5
  statesModel.setName("MIX SWEET ROLES");

  states.add(statesModel);
  statesModel = new States();

  return states;
}