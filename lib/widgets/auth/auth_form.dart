import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  var submitFn;

  AuthForm(this.submitFn, this.isLoading,{super.key});
  final bool isLoading;
     void function(
    String email,
    String username,
    String password,
    bool isLogin,
         BuildContext ctx,
  ){}
   // submitFn;



  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey =GlobalKey<FormState>();
  var _isLogin =true;
  var _userEmail='';
  var _userName='';
  var _userPassword='';


  _submit(){
    final isValid =_formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid!){
      _formKey.currentState!.save();
     widget.submitFn(
       _userEmail.trim(),
       _userPassword.trim(),
         _userName.trim(),
         _isLogin,
         context
     );
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Card(
        margin: EdgeInsets.all(20.0),
        child:SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value){
                    if(value!.isEmpty || !value.contains('@')){
                      return 'pls enter a valid email address';
                    }
                    return null;
                  },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText:'Email address',
                ),
                  onSaved: (value){
                    _userEmail=value!;
                  },
              ),
                if(!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value){
                      if( value!.isEmpty ){
                        return 'pls enter username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText:'username',),
                    onSaved: (value){
                      _userName=value!;
                    },
                  ),

              TextFormField(
                key: ValueKey('password'),
                validator: (value){
                if( value!.isEmpty || value.length < 8){
                  return 'password must be atleast 8 characters';
                }
                return null;
              },
                decoration: InputDecoration(labelText:'password',),
                obscureText: true,
                onSaved: (value){
                  _userPassword=value!;
                },
              ),
                SizedBox(height: 12),
                if(widget.isLoading)CircularProgressIndicator(),
                if(!widget.isLoading)
                ElevatedButton(child: Text(_isLogin ? 'login':'signup'),
                  onPressed: (){
                  _submit();

                  // final isValid =_formKey.currentState?.validate();
                  //   FocusScope.of(context).unfocus();
                  //   if (isValid == true) {
                  //     _formKey.currentState!.save();
                  //     print(_userEmail);
                  //     print(_userName);
                  //     print(_userPassword);
                  //   }

                },),
                if(!widget.isLoading)
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
