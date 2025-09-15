// import 'package:flutter/material.dart';
// import 'package:chat_messenger_app/login/registerscreen.dart';
// import 'package:chat_messenger_app/services/auth_service.dart';
// import 'package:provider/provider.dart';


// class Loginscreen extends StatefulWidget {
//   const Loginscreen({super.key});

//   @override
//   State<Loginscreen> createState() => _Loginscreen();
// }

// class _Loginscreen extends State<Loginscreen> with SingleTickerProviderStateMixin {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _formAnimation;
//   late Animation<double> _helloAnimation;

//   void signIn() async{
//     final authService = Provider.of<AuthService>(context, listen: false);

//     try {
//       await authService.signInWithEmailAndPassword(
//         _emailController.text.trim(),
//         _passwordController.text.trim(),
//       );
//     }catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1600),
//       vsync: this,
//     );
//     _logoAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutBack,
//     );
//     _helloAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
//     );
//     _formAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
//     );
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 FadeTransition(
//                   opacity: _logoAnimation,
//                   child: ScaleTransition(
//                     scale: _logoAnimation,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [Colors.blueAccent, Colors.purpleAccent],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blueAccent.withOpacity(0.2),
//                             blurRadius: 24,
//                             offset: const Offset(0, 8),
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(24),
//                       child: const Icon(
//                         Icons.chat_bubble_rounded,
//                         size: 72,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 FadeTransition(
//                   opacity: _helloAnimation,
//                   child: SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(-0.5, 0),
//                       end: Offset.zero,
//                     ).animate(_helloAnimation),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "👋",
//                           style: theme.textTheme.headlineLarge?.copyWith(fontSize: 36),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           "Hello!",
//                           style: theme.textTheme.headlineLarge?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.purpleAccent,
//                             fontSize: 36,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 FadeTransition(
//                   opacity: _formAnimation,
//                   child: Column(
//                     children: [
//                       Text(
//                         "Welcome Back!",
//                         style: theme.textTheme.headlineMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Sign in to continue chatting",
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       const SizedBox(height: 32),
//                       Material(
//                         elevation: 2,
//                         borderRadius: BorderRadius.circular(16),
//                         child: TextField(
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                             labelText: "Email",
//                             prefixIcon: const Icon(Icons.email_outlined),
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Material(
//                         elevation: 2,
//                         borderRadius: BorderRadius.circular(16),
//                         child: TextField(
//                           controller: _passwordController,
//                           obscureText: _obscurePassword,
//                           decoration: InputDecoration(
//                             labelText: "Password",
//                             prefixIcon: const Icon(Icons.lock_outline),
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//                             filled: true,
//                             fillColor: Colors.white,
//                             suffixIcon: IconButton(
//                               icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
//                               onPressed: () {
//                                 setState(() {
//                                   _obscurePassword = !_obscurePassword;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                             backgroundColor: Colors.blueAccent,
//                             elevation: 4,
//                           ),
//                           onPressed: () {
//                             signIn();
//                           },
//                           child: const Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       TextButton(
//                         onPressed: () {
//                           // TODO: Implement forgot password navigation
//                         },
//                         child: const Text("Forgot Password?", style: TextStyle(color: Colors.purpleAccent)),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Don't have an account?"),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => const RegisterScreen()),
//                               );
//                             },
//                             child: const Text("Sign Up", style: TextStyle(color: Colors.blueAccent)),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:chat_messenger_app/login/registerscreen.dart';
import 'package:chat_messenger_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _Loginscreen();
}

class _Loginscreen extends State<Loginscreen> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _formAnimation;
  late Animation<double> _helloAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _gradientAnimation;

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );

    _helloAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _formAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _gradientAnimation = ColorTween(
      begin: Colors.purpleAccent.withOpacity(0.7),
      end: Colors.blueAccent,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _gradientAnimation.value!,
                  Colors.white,
                  Colors.white,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with enhanced animation
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: FadeTransition(
                      opacity: _logoAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Colors.blueAccent, Colors.purpleAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4),
                              blurRadius: 24,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: const Icon(
                          Icons.chat_bubble_rounded,
                          size: 72,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Hello text with animation
                  FadeTransition(
                    opacity: _helloAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-0.5, 0),
                        end: Offset.zero,
                      ).animate(_helloAnimation),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "👋",
                            style: theme.textTheme.headlineLarge?.copyWith(fontSize: 36),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Hello!",
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.purpleAccent,
                              fontSize: 36,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.purple.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Form with slide and fade animation
                  FadeTransition(
                    opacity: _formAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Text(
                            "Welcome Back!",
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          Text(
                            "Sign in to continue chatting",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[700],
                            ),
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Email field
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                prefixIcon: const Icon(Icons.email_outlined, color: Colors.blueAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Password field
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey[600],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Login button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                signIn();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: Colors.blueAccent,
                                elevation: 6,
                                shadowColor: Colors.blueAccent.withOpacity(0.4),
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text("Login"),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Forgot password
                          TextButton(
                            onPressed: () {
                              // TODO: Implement forgot password navigation
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.purpleAccent,
                            ),
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Sign up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => const RegisterScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        
                                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                        
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                      transitionDuration: const Duration(milliseconds: 500),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blueAccent,
                                ),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}