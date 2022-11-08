import 'dart:io';

import 'package:chatapp/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {


  AuthForm( this.submitFn,this.isLoading,{super.key});
  var submitFn;
  final bool isLoading;
     void function(
    String email,
    String username,
    String password,
    //File image,
    bool isLogin,
         BuildContext ctx,
  ){}



  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey =GlobalKey<FormState>();
  var _isLogin =true;
  var _userEmail='';
  var _userName='';
  var _userPassword='';
 //File? _userImageFile;

  // void _pickedImage(File image) {
  //   _userImageFile = image;
  // }

  void _submit(){
    final isValid =_formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    // if (_userImageFile == null && !_isLogin) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please pick an image.'),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ),
    //   );
    //   return;
    // }
    if (isValid! ){
      _formKey.currentState!.save();
     widget.submitFn(
       _userEmail.trim(),
       _userPassword.trim(),
         _userName.trim(),
        //_userImageFile,
         _isLogin,
         context
     );
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child:SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if (!_isLogin)
                //   UserImagePicker(_pickedImage ),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value){
                    if(value!.isEmpty || !value!.contains('@')){
                      return 'pls enter a valid email address';
                    }
                    return null;
                  },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText:'Email address',
                ),
                  onSaved: (value){
                    _userEmail=value!;
                  },
              ),
                if(!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator: (value){
                      if( value!.isEmpty ){
                        return 'pls enter username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText:'username',),
                    onSaved: (value){
                      _userName=value!;
                    },
                  ),

              TextFormField(
                key: const ValueKey('password'),
                validator: (value){
                if(value!.isEmpty || value.length < 8){
                  return 'password must be atleast 8 characters';
                }
                return null;
              },
                decoration: const InputDecoration(labelText:'password',),
                obscureText: true,
                onSaved: (value){
                  _userPassword=value!;
                },
              ),
                const SizedBox(height: 12),

                ElevatedButton(child: Text(_isLogin ? 'login':'signup'),
                  onPressed: (){
                  _submit();


                },),

                TextButton(child: Text(_isLogin ? 'create new account':'I already have an account'),
                  onPressed: (){
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },)
            ],),),
          ),) ,),);
  }
}
