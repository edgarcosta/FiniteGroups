intrinsic MakeSmallGroup(N::RngIntElt, i::RngIntElt) -> Any
    {Create an LMFDBGrp object for SmallGroup(N,i) and compute attributes}
    G := NewLMFDBGrp(SmallGroup(N, i), Sprintf("%o.%o", N, i));
    // G`subgroup_index_bound := N;
    // For now we compute everything, so we don't set
    G`subgroup_index_bound := 0;
    G`all_subgroups_known := true;
    G`normal_subgroups_known := true;
    G`maximal_subgroups_known := true;
    G`sylow_subgroups_known := true;
    G`outer_equivalence := false;
    G`subgroup_inclusions_known := true;
    AssignBasicAttributes(G);
    return G;
end intrinsic;

intrinsic MakeSmallGroupData(N::RngIntElt, i::RngIntElt) -> Tup
  {Create the information for saving a small group to several files.  Returns a triple (one for each file) of lists of strings (one for each entry to be saved)}
  G := MakeSmallGroup(N,i);
  return PrintData(G);
end intrinsic;

intrinsic MakeSmallGroupGLnData(N::RngIntElt, i::RngIntElt) -> Tup
  {Create the information for saving a small group to several files.  Returns a triple (one for each file) of lists of strings (one for each entry to be saved)}
  G := MakeSmallGroup(N,i);
  return PrintGLnData(G);
end intrinsic;

/* Sorry, made by copy/paste and tailored to me */
Folder:="JJ-test/";
Proc:="0";
files := [Folder * "groups/" * Proc * ".txt",
          Folder * "subgroups/" * Proc * ".txt",
          Folder * "groups_cc/" * Proc * ".txt",
          Folder * "characters_cc/" * Proc * ".txt",
          Folder * "characters_qq/" * Proc * ".txt",
          Folder * "glnq/" * Proc * ".txt",
          Folder * "glnc/" * Proc * ".txt"];
logfile:= Folder * "logs/" * Proc * ".txt";

intrinsic WriteSmallGroupGLn(N::RngIntElt, i::RngIntElt)
    {}
    PrintFile(logfile, Sprintf("Starting GLn small group %o.%o", N, i));
    t0 := Cputime();
    print_data := MakeSmallGroupGLnData(N, i);
    t1 := Cputime();
    PrintFile(logfile, Sprintf("GLn small group %o.%o took %o s", N, i, t1-t0));
    for j in [1..2] do
        for line in print_data[j] do
            PrintFile(files[5+j], line);
        end for;
    end for;
end intrinsic;

intrinsic WriteSmallGLnOrder(N::RngIntElt)
  {}
  for j:=1 to NumberOfSmallGroups(N) do
    WriteSmallGroupGLn(N,j);
  end for;
end intrinsic;
