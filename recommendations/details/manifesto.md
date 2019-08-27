# Engineering Manifesto

- At Moda Tech, we uphold building resilient systems. We always ask ourselves, how will this hold up over time? We prioritize refactoring where we see necessary either for longevity or preventing issues in the future. We try to anticipate and prevent failures constantly while developing. When we do have failures, we learn from them and share them with others to hopefully prevent in the future.

- We differentiate between “core” systems (that must be functional and require minimal downtime) and “non-core” systems - and strive to minimize the former. We gracefully degrade in the face of downtime of “non-core” systems and don’t unintentionally create hard dependencies on such systems.

- We always test our work rigorously before releasing. When our work goes into QA, we expect no additional bugs to be filed from QA. We value unit and integration tests as well as making sure if a bug is fixed it has a test to make sure there is not a regression. 

- We value writing code that is easy to maintain and easy to understand. We document context through: comments within code, commit comments, JIRA tickets, API specs, and/or long-form documentation in Confluence. We strive for appropriate separation of concerns at all levels, composing discrete components and striving to avoid unintended side effects.

- We build features with respect for our users and their privacy and we treat security as a top-level concern. We aim for great performance as it provides a better experience for our users. 

- We try to keep moving projects forward and not succumb to analysis paralysis. If blocked, we ask for help and input to keep moving forward and release. We encourage a culture of “ask for forgiveness, not permission.” We prioritize “two-way doors”, include rollbacks plans as part of the deployment strategy, and fail back to previous state in the face of unanticipated issues.

- We feel like there is always more to learn. We strive for continuously expanding our knowledge of our own systems as well as reading about new tools which may be beneficial to use at Moda. We introduce new technologies in a manner that can be supported in the absence of an individual.

- Mentoring and Growing Team Members: we conduct technological conversations in public forums, to elevate the skills of those around us and we look for opportunities for others to take on “stretch” tasks, with a level of support that sets them up for success.

- It is important to review pull requests for team members and provide feedback. We never use pull requests to demonstrate individual brilliance, this is merely a useful tool for providing friendly feedback so that we can continuously improve our code. We listen to others and are open to feedback. We don’t get hung up on minutiae, but do stand up for the important decisions.

- We have loosely held opinions on designs and architecture. We are passionate in our beliefs, but understand that the group may make different decisions. We adopt a policy of “disagree but commit” when decisions don’t go in our favor. When comments are requested from us, we give them - but it is up to the requester to make the final decision on whether or not to incorporate them.

- We try to make good decisions with imperfect information to the best of our ability. Progress might be measured in the amount of oversight we need to get the job done, or how early in the evolution of an idea we can successfully take ownership. We continuously refine requirements until they are clear, and check back to ensure we are delivering features that meet those requirements. We understand that priorities may change, and make it clear what will be given up in order to re-prioritize. New requirements and increased effort cannot be simply absorbed, but it is our responsibility to communicate the trade-offs.

