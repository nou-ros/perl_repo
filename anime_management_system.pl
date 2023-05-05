#!/usr/bin/env perl

#Anime List
sub anime_list{
    @name_list=();
    $filename='animelist.txt';
    open(FILE, "<", $filename);
    while($name=<FILE>){
        push(@name_list, $name);
    }    
    close(FILE);
}


# show arrayList
sub get_animes{
    print("\nAnimes: \n\n");
    foreach $name_of_anime (@name_list){
        print("$name_of_anime\n"); 
    }
}


# adding in files
sub adding_new_anime{
    print("\nEnter name of a new Anime: ");
    $new_anime=<STDIN>;
    $filename='animelist.txt';
    open(FILE, ">>", $filename) or die;
    print FILE "$new_anime";
    close(FILE);
    print("\nNew anime added succesfully\n");
}


# deleting from files
sub deleting_anime{
    print("\nEnter anime name: \n");
    $anime_name=<STDIN>;
    chomp($anime_name);
    my $index_to_delete = -1;
    for my $i (0..$#name_list) {
        if (lc($name_list[$i]) eq lc($anime_name)) {
            $index_to_delete = $i;
            last;
        }
    }

    # Delete the string from the array
    if ($index_to_delete >= 0) {
        splice @name_list, $index_to_delete, 1;
    }
    `grep -iv "$anime_name" ./animelist.txt > tmp-file && mv tmp-file ./animelist.txt`;
    print("\n$anime_name is deleted\n");
}


# searching from arrayList 
sub search_for_anime{
    print("\nEnter anime name you want to search: ");
    $anime_name=<STDIN>;
    foreach $name (@name_list){
        chomp ($name, $anime_name);
        if(lc($anime_name) eq lc($name)){
            print("\n$name found in the anime list.\n");
            return;
        }
        print("\nSorry $anime_name was not found in the list!!!\n");
    }
}


#Menu UI
sub menu_options{

    #displaying user options
    print("\n ------ Anime Repo -------\n");
    print("\n1. Search for anime\n");
    print("\n2. Add an anime\n");
    print("\n3. Get all the list of animes\n");
    print("\n4. Delete from the anime list\n");
    print("\n5. Quit the anime portal\n");

    #printing the selected option
    print("\nSelect an option: ");
    chomp($selected_item=<STDIN>);

    return $selected_item;
}


&anime_list();
$selected_options=&menu_options();

while($selected_options!=5)
{
    if($selected_options==1){
        &search_for_anime();
        $selected_options=&menu_options();
    }
    elsif($selected_options==2){
        &adding_new_anime();
        &anime_list();
        $selected_options=&menu_options();
    }
    elsif($selected_options==3){
        &get_animes();
        $selected_options=&menu_options();
    }

    elsif($selected_options==4){
        &deleting_anime();
        $selected_options=&menu_options();
    }

    else{
        print("\n\nPlease enter a menu options to continue\n\n");
        $selected_options=&menu_options();
    }
}