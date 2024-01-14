class OnBoarding {
  String title;
  String image;
  String discription;

  OnBoarding(
      {required this.image, required this.title, required this.discription});
}

List<OnBoarding> contents = [
  OnBoarding(
      image: 'assets/1.png',
      title: 'Your Way',
      discription:
          'Our fitness planner is designed to empower you on your wellness journey. Plan your workouts, track your progress, and embrace a healthier lifestyle. Achieve your fitness goals with structured exercises, nutrition guidance, and a supportive community.'),
  OnBoarding(
      image: 'assets/2.png',
      title: 'Professional Coaches',
      discription:
          'your gateway to personalized online coaching! Elevate your fitness journey with expert guidance anytime, anywhere. Our coaching platform brings fitness professionals directly to you, offering tailored workout plans, nutrition advice, and continuous support. Whether youre a beginner or a seasoned pro, unlock your full potential with our interactive coaching experience.'),
  OnBoarding(
      image: 'assets/PFP__1_-removebg-preview.png',
      title: 'Welcome to physical fitness planner',
      discription:
          'Welcome to a world of fitness designed just for you. Its time to take the first step towards a healthier, stronger, and more energetic version of yourself. Whether youre a beginner or a fitness enthusiast, our app is here to guide you every step of the way. Lets kickstart your journey to a fitter, happier you. Ready to begin?"')
];
