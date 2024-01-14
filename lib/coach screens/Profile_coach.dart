import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/data/coash_customer.dart';
import 'package:physical_fitness_planner/field_info.dart';
import 'package:physical_fitness_planner/hepler/webview_helper.dart';

class ProfileCoach extends StatefulWidget {
  bool showinformation;
  Coach coach;
  ProfileCoach({super.key, required this.showinformation, required this.coach});

  @override
  State<ProfileCoach> createState() => _ProfileCoachState();
}

class _ProfileCoachState extends State<ProfileCoach> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.linearToEaseOut,
      width: MediaQuery.of(context).size.width * 0.95,
      height: !widget.showinformation
          ? MediaQuery.of(context).size.height * 0.25
          : MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
              image: AssetImage('assets/redContaier.jpg'), fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.coach.photoUrl),
                    radius: MediaQuery.of(context).size.width * 0.125,
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.coach.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          Text(
                            widget.coach.specialization,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            widget.coach.speciality,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          Text(
                            '${widget.coach.city},${widget.coach.country}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                height: 20,
                                width: 120,
                              ),
                              if (!widget.showinformation)
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.showinformation = true;
                                      });
                                    },
                                    child: const Text(
                                      'See more...',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.showinformation) ...[
                const Divider(
                  color: Colors.white,
                ),
                FieldInfo(title: 'Email', info: widget.coach.email),
                const Divider(
                  color: Colors.white,
                ),
                FieldInfo(title: 'Mobile N0', info: widget.coach.phoneNumber),
                const Divider(
                  color: Colors.white,
                ),
                FieldInfo(title: 'Date of birth', info: widget.coach.dateOfB),
                const Divider(
                  color: Colors.white,
                ),
                FieldInfo(title: 'Gender', info: widget.coach.gender),
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  'Social links',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Expanded(
                  child: ListView.builder(

                      // physics: NeverScrollableScrollPhysics(),

                      scrollDirection: Axis.horizontal,
                      itemCount: widget.coach.coachSocialMedia.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 10, top: 10),
                          child: GestureDetector(
                            onTap: () {
                              startWebView(
                                  context,
                                  widget.coach.coachSocialMedia[i].url,
                                  widget.coach.coachSocialMedia[i].url);
                            },
                            child: Image.asset(
                                widget.coach.coachSocialMedia[i].picture),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.showinformation = false;
                            });
                          },
                          child: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  ],
                )
              ],
            ]),
      ),
    );
  }
}
