
class Student_Details
{
  String name,age,f_name,m_name,uid,school;
  String dob,g_phone,p_phone,blood_group;
  String address,illness,email,sport,venue,category;
  String imageURL;
  int std,profile_count,selecting_factor,sport_id,venue_id,grp_id;

  getDetails(name,age,school,dob,sport,address,email,venue,std,imageURL,contact,p_contact,cat){
    this.name = name;
    this.age = age;
    this.email = email;
    this.dob = dob;
    this.address = address;
    this.sport = sport;
    this.school = school;
    this.venue = venue;
    this.std = std;
    this.imageURL = imageURL;
    this.g_phone = contact;
    this.p_phone = p_contact;
    this.category = cat;
  }

  toJson(){
    return{
      "Name" : name,
      "DOB" : dob,
      "Age" : age,
      "School Name" : school,
      "Contact Number" : g_phone,
      "Address" : address,
      "Blood group" : blood_group,
      "Father's name" : f_name,
      "Mother's name" : m_name,
      "Parent's Contact" : p_phone,
      "Major illness" : illness,
      "Email-id" : email,
      "Sport" : sport,
      "Venue" : venue,
      "Class" : std,
      "Profile Count" : profile_count,
      "Selecting Factor" : selecting_factor,
      "Category" : category,
    };

  }


  toJsonList(){
    return{
      "Name" : name,
      "Age" : age,
      "School Name" : school,
      "Sport" : sport,
      "Venue" : venue,
      "Class" : std,
      "Uid" : uid,
      "Selecting Factor" : selecting_factor,
      "ProfileNo" : profile_count,
    };
  }

  toJsonImage(){
    return{
      "ImageURL" : imageURL,
    };
  }
  toJsonCount(){
    return{
      "Profile Count" : profile_count,
    };
  }
  toJsonUpdate(){
    return{
      "Age" : age,
      "School Name" : school,
      "Contact Number" : g_phone,
      "Parent's Contact" : p_phone,
      "Class" : std,
    };
  }

   toJsonAge()
   {
     return {
       "Age" : age,
     };
   }

   calc_factor(){
    selecting_factor = 100*sport_id + 10*venue_id + grp_id;
   }

   calc_age(){
    var edit_date = dob.split('/');
    var day = int.parse(edit_date[0]);
    var mon = int.parse(edit_date[1]);
    var year = int.parse(edit_date[2]);
    DateTime dateTime = DateTime.now();
    int e_age = dateTime.year - year;
    if(mon > dateTime.month)
    {
      e_age--;
      print(e_age);

    }
    else if(mon == dateTime.month)
      {
        if(day > dateTime.day)
          {
            e_age = e_age - 1;
            print(e_age);
          }
      }
    age = e_age.toString();
  }

}