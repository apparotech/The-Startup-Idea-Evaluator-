import 'package:flutter/material.dart';
import 'package:idea_envalutor/Service/fake_ai_service.dart';
import 'package:idea_envalutor/model/Idea.dart';
import 'package:idea_envalutor/viewModel/idea_provider.dart';
import 'package:provider/provider.dart';

import '../utils/snackbar_utils.dart';
import '../viewModel/theme_provider.dart';

class IdeaSubmissionScreen extends StatefulWidget {
  const IdeaSubmissionScreen({super.key});

  @override
  State<IdeaSubmissionScreen> createState() => _IdeaSubmissionScreenState();
}

class _IdeaSubmissionScreenState extends State<IdeaSubmissionScreen> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _descriptionController = TextEditingController();


  void _submitIdea() {
    if (_formKey.currentState!.validate()) {

      int rating = generateSmartFakeRating(
        _nameController.text,
        _descriptionController.text,
      );


      Idea newIdea = Idea(
        name: _nameController.text.trim(),
        tagline: _taglineController.text.trim(),
        description: _descriptionController.text.trim(),
        rating: rating,
      );


      Provider.of<IdeaProvider>(context, listen: false).addIdea(newIdea);
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final isDark = themeProvider.isDarkMode;


      showCustomSnackBar(context, "Idea submitted! AI Rating: $rating", bgColor: isDark ? Colors.purple : Colors.blue );
      Navigator.pushNamed(context, '/');

      _nameController.clear();
      _taglineController.clear();
      _descriptionController.clear();

    } else {

     showCustomSnackBar(context, "Please fill all fields before submitting");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Scaffold(

      appBar: AppBar(
        elevation: 2,
        title: const Text('Submit Your Startup Idea 🚀'),
        backgroundColor: isDark ? Colors.purple : Colors.blue,
        actions: [
          IconButton(
              onPressed: () => themeProvider.toggleTheme(),
              icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),

          )
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(16.0),

          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextFiled('Startup Name', _nameController, isDark) ,
                  _buildTextFiled("Tagline", _taglineController, isDark),
                  _buildTextFiled('Description', _descriptionController, isDark,maxLines: 5),

                  const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.purple : Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                      onPressed: () {
                        _submitIdea();
                      },
                      child:const Text("Submit Idea"),
                  )
                ],
              )
          ),
      ),
    );
  }
/*
  Widget _buildTextFiled(String label, TextEditingController controller, bool isDark, {int maxLines =1}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),

      child: TextFormField(
        controller: controller,
         maxLines: maxLines,
         validator: (value)  => value!.isEmpty ? 'Please enter the $label' : null,
         decoration: InputDecoration(
           labelText: label,
           labelStyle: const TextStyle(
               color: isDark ? Colors.purple : Colors.blue
           ),
           filled: true,
           fillColor: Colors.white,
           enabledBorder: OutlineInputBorder(
             borderSide:  const BorderSide(color: Colors.blue),
             borderRadius: BorderRadius.circular(8),
           ),
           focusedBorder: OutlineInputBorder(
             borderSide: const BorderSide(


                 width: 2,
               color: isDark ? Colors.purple : Colors.blue,
             ),
               borderRadius: BorderRadius.circular(8),
           )
         ),
      ),
    );
  }

 */

  Widget _buildTextFiled(
      String label, TextEditingController controller, bool isDark,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) => value!.isEmpty ? "Please enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: isDark ? Colors.purple : Colors.blue,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDark ? Colors.purple : Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDark ? Colors.purple : Colors.blue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 2,
              color: isDark ? Colors.purple : Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
