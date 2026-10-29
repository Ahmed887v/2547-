import '../models/lesson.dart';

const List<Unit> curriculum = [
  Unit(
    id: 'u1',
    title: 'Unit 1 · Greetings',
    description: 'Say hello and introduce yourself',
    lessons: [
      Lesson(
        id: 'l1',
        title: 'Hello Basics',
        subtitle: 'Greet people politely',
        emoji: '👋',
        color: ColorSeed.green,
        xpReward: 20,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Hello',
              meaningAr: 'مرحبا',
              tip: 'Stress the second syllable lightly: he-LLO',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Hi, how are you?',
              meaningAr: 'مرحبا، كيف حالك؟',
              tip: 'Keep “how are you” smooth and friendly',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Nice to meet you',
              meaningAr: 'سررت بلقائك',
              tip: 'Link “meet you” → “mee-choo”',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Good morning',
              meaningAr: 'صباح الخير',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Have a great day',
              meaningAr: 'أتمنى لك يوماً رائعاً',
            ),
            choices: ['Have a great day', 'See you never', 'Good night only'],
          ),
        ],
      ),
      Lesson(
        id: 'l2',
        title: 'Introduce Yourself',
        subtitle: 'Name, city, and feelings',
        emoji: '🗣️',
        color: ColorSeed.blue,
        xpReward: 25,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'My name is Alex',
              meaningAr: 'اسمي أليكس',
              tip: 'Say your own name when you practice',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I am learning English',
              meaningAr: 'أنا أتعلم الإنجليزية',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I live in Cairo',
              meaningAr: 'أسكن في القاهرة',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I am happy today',
              meaningAr: 'أنا سعيد اليوم',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Nice to talk to you',
              meaningAr: 'سررت بالحديث معك',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l3',
        title: 'Polite Phrases',
        subtitle: 'Please, thanks, and sorry',
        emoji: '🙏',
        color: ColorSeed.orange,
        xpReward: 25,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(text: 'Please', meaningAr: 'من فضلك'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase:
                Phrase(text: 'Thank you very much', meaningAr: 'شكراً جزيلاً'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase:
                Phrase(text: 'You are welcome', meaningAr: 'على الرحب والسعة'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(text: 'I am sorry', meaningAr: 'أنا آسف'),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(text: 'Excuse me', meaningAr: 'اعذرني / لو سمحت'),
            choices: ['Excuse me', 'Shut up', 'Never mind me'],
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u2',
    title: 'Unit 2 · Daily Life',
    description: 'Talk about routines and food',
    lessons: [
      Lesson(
        id: 'l4',
        title: 'Daily Routine',
        subtitle: 'Morning to night',
        emoji: '☀️',
        color: ColorSeed.yellow,
        xpReward: 30,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(text: 'I wake up early', meaningAr: 'أستيقظ مبكراً'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(text: 'I brush my teeth', meaningAr: 'أنظف أسناني'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(text: 'I go to work', meaningAr: 'أذهب إلى العمل'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(text: 'I study at night', meaningAr: 'أذاكر ليلاً'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(text: 'I go to bed late', meaningAr: 'أنام متأخراً'),
          ),
        ],
      ),
      Lesson(
        id: 'l5',
        title: 'Food & Orders',
        subtitle: 'Order like a pro',
        emoji: '🍽️',
        color: ColorSeed.purple,
        xpReward: 30,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I would like some water',
              meaningAr: 'أريد بعض الماء',
              tip: '“Would like” sounds softer than “want”',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
                text: 'Can I have the menu?',
                meaningAr: 'هل يمكنني الحصول على القائمة؟'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
                text: 'This tastes delicious', meaningAr: 'هذا طعمه لذيذ'),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase:
                Phrase(text: 'No sugar, please', meaningAr: 'بدون سكر من فضلك'),
            choices: [
              'No sugar, please',
              'More salt forever',
              'Burn it please'
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase:
                Phrase(text: 'The bill, please', meaningAr: 'الفاتورة من فضلك'),
          ),
        ],
      ),
      Lesson(
        id: 'l6',
        title: 'Asking Questions',
        subtitle: 'Where, when, how',
        emoji: '❓',
        color: ColorSeed.blue,
        xpReward: 35,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase:
                Phrase(text: 'Where is the station?', meaningAr: 'أين المحطة؟'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(text: 'How much is this?', meaningAr: 'بكم هذا؟'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(text: 'What time is it?', meaningAr: 'كم الساعة؟'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
                text: 'Can you help me?', meaningAr: 'هل يمكنك مساعدتي؟'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
                text: 'Could you repeat that?',
                meaningAr: 'هل يمكنك إعادة ذلك؟'),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u3',
    title: 'Unit 3 · Confidence',
    description: 'Travel, work, and fluency boosters',
    lessons: [
      Lesson(
        id: 'l7',
        title: 'Travel Talk',
        subtitle: 'Airports and hotels',
        emoji: '✈️',
        color: ColorSeed.green,
        xpReward: 35,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(text: 'I have a reservation', meaningAr: 'لدي حجز'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
                text: 'Where is my gate?', meaningAr: 'أين بوابة رحلتي؟'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase:
                Phrase(text: 'My flight is delayed', meaningAr: 'رحلتي متأخرة'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
                text: 'I need a taxi', meaningAr: 'أحتاج إلى سيارة أجرة'),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
                text: 'Is breakfast included?', meaningAr: 'هل الإفطار مشمول؟'),
            choices: [
              'Is breakfast included?',
              'Is breakfast forbidden?',
              'Is breakfast imaginary?',
            ],
          ),
        ],
      ),
      Lesson(
        id: 'l8',
        title: 'Work English',
        subtitle: 'Meetings and emails',
        emoji: '💼',
        color: ColorSeed.orange,
        xpReward: 40,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
                text: 'Let us start the meeting',
                meaningAr: 'دعنا نبدأ الاجتماع'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(text: 'I agree with you', meaningAr: 'أوافقك الرأي'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
                text: 'Could you send the file?',
                meaningAr: 'هل يمكنك إرسال الملف؟'),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
                text: 'I will follow up tomorrow', meaningAr: 'سأتابع غداً'),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
                text: 'Thank you for your time', meaningAr: 'شكراً لوقتك'),
          ),
        ],
      ),
      Lesson(
        id: 'l9',
        title: 'Fluency Boost',
        subtitle: 'Longer natural sentences',
        emoji: '🚀',
        color: ColorSeed.purple,
        xpReward: 45,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I practice English every day',
              meaningAr: 'أتمرن على الإنجليزية كل يوم',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Speaking slowly helps me improve',
              meaningAr: 'التحدث ببطء يساعدني على التحسن',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I feel more confident now',
              meaningAr: 'أشعر بثقة أكبر الآن',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Please correct my pronunciation',
              meaningAr: 'من فضلك صحح نطقي',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Practice makes progress',
              meaningAr: 'الممارسة تصنع التقدم',
              tip: 'Smile while you say it — confidence shows',
            ),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u4',
    title: 'Unit 4 · Building Sentences',
    description: 'Build clear sentences, negatives, and questions',
    lessons: [
      Lesson(
        id: 'l10',
        title: 'Word Order',
        subtitle: 'Put words in the right order',
        emoji: '🧩',
        color: ColorSeed.green,
        xpReward: 40,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I drink water every day',
              meaningAr: 'أنا أشرب الماء كل يوم',
              tip: 'A common order is subject + verb + object.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'She reads a book',
              meaningAr: 'هي تقرأ كتاباً',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We learn English together',
              meaningAr: 'نحن نتعلم الإنجليزية معاً',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'They play football after school',
              meaningAr: 'هم يلعبون كرة القدم بعد المدرسة',
              tip: 'Start with the subject: They.',
            ),
            choices: [
              'They play football after school',
              'Football they after school play',
              'After play they football school',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I usually wake up early',
              meaningAr: 'عادةً ما أستيقظ مبكراً',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l11',
        title: 'Am, Is, Are',
        subtitle: 'Describe people and things',
        emoji: '🔤',
        color: ColorSeed.blue,
        xpReward: 40,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I am ready',
              meaningAr: 'أنا مستعد',
              tip: 'Use am with I.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'She is happy',
              meaningAr: 'هي سعيدة',
              tip: 'Use is with he, she, and it.',
            ),
            choices: ['She is happy', 'She are happy', 'She am happy'],
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'They are at home',
              meaningAr: 'هم في المنزل',
              tip: 'Use are with you, we, and they.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We are good friends',
              meaningAr: 'نحن أصدقاء جيدون',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'He is my brother',
              meaningAr: 'هو أخي',
            ),
            choices: [
              'He is my brother',
              'He are my brother',
              'He am my brother',
            ],
          ),
        ],
      ),
      Lesson(
        id: 'l12',
        title: 'Negative Sentences',
        subtitle: 'Say what is not true',
        emoji: '🚫',
        color: ColorSeed.orange,
        xpReward: 45,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I am not tired',
              meaningAr: 'أنا لست متعباً',
              tip: 'Put not after am, is, or are.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'She is not busy',
              meaningAr: 'هي ليست مشغولة',
            ),
            choices: [
              'She is not busy',
              'She not is busy',
              'She are not busy',
            ],
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I do not understand',
              meaningAr: 'أنا لا أفهم',
              tip:
                  'Use do not with I, you, we, and they in the present simple.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We do not live here',
              meaningAr: 'نحن لا نعيش هنا',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'He does not like coffee',
              meaningAr: 'هو لا يحب القهوة',
              tip: 'Use does not with he, she, and it.',
            ),
            choices: [
              'He does not like coffee',
              'He do not likes coffee',
              'He not does like coffee',
            ],
          ),
        ],
      ),
      Lesson(
        id: 'l13',
        title: 'Ask Questions',
        subtitle: 'Turn sentences into questions',
        emoji: '❓',
        color: ColorSeed.purple,
        xpReward: 50,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Are you ready?',
              meaningAr: 'هل أنت مستعد؟',
              tip: 'With am, is, and are, put the verb before the subject.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Is she your teacher?',
              meaningAr: 'هل هي معلمتك؟',
            ),
            choices: [
              'Is she your teacher?',
              'She is your teacher?',
              'Does she is your teacher?',
            ],
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Do you speak English?',
              meaningAr: 'هل تتحدث الإنجليزية؟',
              tip: 'Use do for questions with I, you, we, and they.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Where do you live?',
              meaningAr: 'أين تعيش؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Does he work here?',
              meaningAr: 'هل يعمل هنا؟',
              tip: 'After does, use the base form: work, not works.',
            ),
            choices: [
              'Does he work here?',
              'Does he works here?',
              'Do he work here?',
            ],
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u5',
    title: 'Unit 5 · The Living City',
    description: 'Handle real-life situations around town',
    lessons: [
      Lesson(
        id: 'l14',
        title: 'Finding Your Way',
        subtitle: 'Ask for and understand directions',
        emoji: '🧭',
        color: ColorSeed.blue,
        xpReward: 50,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Could you tell me how to get to the museum?',
              meaningAr: 'هل يمكنك أن تخبرني كيف أصل إلى المتحف؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Go straight until you reach the bridge.',
              meaningAr: 'سر مباشرة حتى تصل إلى الجسر.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Turn left at the traffic lights.',
              meaningAr: 'انعطف يسارًا عند إشارة المرور.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Is it within walking distance?',
              meaningAr: 'هل يمكن الوصول إليه سيرًا؟',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Is it within walking distance?',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I think we have taken the wrong street.',
              meaningAr: 'أعتقد أننا سلكنا الشارع الخطأ.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l15',
        title: 'At the Pharmacy',
        subtitle: 'Explain a simple need',
        emoji: '💊',
        color: ColorSeed.blue,
        xpReward: 50,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I have a sore throat.',
              meaningAr: 'أعاني من التهاب في الحلق.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Do you have anything for a headache?',
              meaningAr: 'هل لديكم شيء للصداع؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'How often should I take this?',
              meaningAr: 'كم مرة ينبغي أن أتناول هذا؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Are there any side effects?',
              meaningAr: 'هل توجد آثار جانبية؟',
            ),
            choices: [
              'Are there any side effects?',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I will check with a pharmacist first.',
              meaningAr: 'سأستشير الصيدلي أولًا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l16',
        title: 'Making a Complaint',
        subtitle: 'Describe a problem politely',
        emoji: '🛠️',
        color: ColorSeed.blue,
        xpReward: 50,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'There seems to be a problem with my order.',
              meaningAr: 'يبدو أن هناك مشكلة في طلبي.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I am afraid this is not what I asked for.',
              meaningAr: 'أخشى أن هذا ليس ما طلبته.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Could you look into this, please?',
              meaningAr: 'هل يمكنك التحقق من الأمر من فضلك؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I would appreciate a replacement.',
              meaningAr: 'سأقدّر توفير بديل.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'I would appreciate a replacement.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Thank you for helping me sort this out.',
              meaningAr: 'شكرًا لمساعدتي في حل هذه المشكلة.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l17',
        title: 'Public Transport',
        subtitle: 'Travel across the city',
        emoji: '🚌',
        color: ColorSeed.blue,
        xpReward: 52,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Does this bus stop near the university?',
              meaningAr: 'هل تتوقف هذه الحافلة بالقرب من الجامعة؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Where can I top up my travel card?',
              meaningAr: 'أين يمكنني شحن بطاقة المواصلات؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I need a ticket for the next stop.',
              meaningAr: 'أحتاج تذكرة للمحطة التالية.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The train is running about ten minutes late.',
              meaningAr: 'يتأخر القطار نحو عشر دقائق.',
            ),
            choices: [
              'The train is running about ten minutes late.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Please let me know when we arrive.',
              meaningAr: 'من فضلك أخبرني عندما نصل.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l18',
        title: 'Renting a Room',
        subtitle: 'Ask about accommodation',
        emoji: '🏠',
        color: ColorSeed.blue,
        xpReward: 52,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Is the room available from next Monday?',
              meaningAr: 'هل الغرفة متاحة ابتداءً من الاثنين القادم؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Are utilities included in the rent?',
              meaningAr: 'هل الفواتير مشمولة في الإيجار؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Could I see the place before deciding?',
              meaningAr: 'هل يمكنني معاينة المكان قبل اتخاذ القرار؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The neighborhood seems quiet and convenient.',
              meaningAr: 'يبدو الحي هادئًا ومناسبًا.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'The neighborhood seems quiet and convenient.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I would like to read the agreement carefully.',
              meaningAr: 'أود قراءة الاتفاق بعناية.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l19',
        title: 'At the Bank',
        subtitle: 'Handle everyday transactions',
        emoji: '🏦',
        color: ColorSeed.blue,
        xpReward: 52,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I would like to open a bank account.',
              meaningAr: 'أود فتح حساب بنكي.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Could you explain this charge?',
              meaningAr: 'هل يمكنك توضيح هذه الرسوم؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I seem to have forgotten my PIN.',
              meaningAr: 'يبدو أنني نسيت الرقم السري.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'How long will the transfer take?',
              meaningAr: 'كم سيستغرق التحويل؟',
            ),
            choices: [
              'How long will the transfer take?',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Could I have a printed receipt?',
              meaningAr: 'هل يمكنني الحصول على إيصال مطبوع؟',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l20',
        title: 'Meeting Neighbors',
        subtitle: 'Build friendly relationships',
        emoji: '🌳',
        color: ColorSeed.blue,
        xpReward: 54,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We have just moved in next door.',
              meaningAr: 'لقد انتقلنا للتو إلى المنزل المجاور.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Please let us know if we are too noisy.',
              meaningAr: 'أخبرنا من فضلك إذا كنا نُحدث ضوضاء.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Would you like to join us for coffee?',
              meaningAr: 'هل تود الانضمام إلينا لتناول القهوة؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Do you know a good place to buy groceries?',
              meaningAr: 'هل تعرف مكانًا جيدًا لشراء البقالة؟',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Do you know a good place to buy groceries?',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'It is nice to finally meet everyone.',
              meaningAr: 'يسعدني أخيرًا التعرف إلى الجميع.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l21',
        title: 'Unexpected Delays',
        subtitle: 'Explain a change of plans',
        emoji: '⏳',
        color: ColorSeed.blue,
        xpReward: 54,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I am stuck in traffic and may be late.',
              meaningAr: 'أنا عالق في الزحام وقد أتأخر.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Would it be possible to reschedule?',
              meaningAr: 'هل يمكن إعادة تحديد الموعد؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I will keep you updated.',
              meaningAr: 'سأبقيك على اطلاع.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Something unexpected has come up.',
              meaningAr: 'حدث أمر غير متوقع.',
            ),
            choices: [
              'Something unexpected has come up.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Sorry for the inconvenience this has caused.',
              meaningAr: 'أعتذر عن الإزعاج الذي سببه هذا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l22',
        title: 'City Challenge',
        subtitle: 'Combine everyday communication skills',
        emoji: '🎯',
        color: ColorSeed.blue,
        xpReward: 54,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Could you recommend somewhere affordable to eat?',
              meaningAr: 'هل يمكنك ترشيح مكان مناسب السعر لتناول الطعام؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I am looking for a quieter route.',
              meaningAr: 'أبحث عن طريق أكثر هدوءًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Let me make sure I have understood correctly.',
              meaningAr: 'دعني أتأكد أنني فهمت بشكل صحيح.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'If I miss this bus, what are my options?',
              meaningAr: 'إذا فاتتني هذه الحافلة، فما الخيارات المتاحة؟',
            ),
            choices: [
              'I am not entirely sure about that.',
              'If I miss this bus, what are my options?',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Thanks for being so helpful.',
              meaningAr: 'شكرًا لكونك متعاونًا جدًا.',
            ),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u6',
    title: 'Unit 6 · Mystery Files',
    description: 'Follow clues and make careful inferences',
    lessons: [
      Lesson(
        id: 'l23',
        title: 'The Missing Key',
        subtitle: 'Describe clues and possibilities',
        emoji: '🔑',
        color: ColorSeed.purple,
        xpReward: 55,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The key was on the desk a moment ago.',
              meaningAr: 'كان المفتاح على المكتب منذ لحظة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Someone may have moved it.',
              meaningAr: 'ربما نقله أحدهم.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'There are muddy footprints by the window.',
              meaningAr: 'توجد آثار أقدام موحلة قرب النافذة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'That does not necessarily mean someone broke in.',
              meaningAr: 'هذا لا يعني بالضرورة أن أحدًا اقتحم المكان.',
            ),
            choices: [
              'That does not necessarily mean someone broke in.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let us check the hallway before guessing.',
              meaningAr: 'لنتفقد الممر قبل التخمين.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l24',
        title: 'A Strange Message',
        subtitle: 'Interpret an unclear message',
        emoji: '📩',
        color: ColorSeed.purple,
        xpReward: 55,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The message was sent just before midnight.',
              meaningAr: 'أُرسلت الرسالة قبل منتصف الليل بقليل.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'It could be a warning, but we cannot be sure.',
              meaningAr: 'قد تكون تحذيرًا، لكننا لا نستطيع التأكد.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The wording is deliberately vague.',
              meaningAr: 'الصياغة غامضة عمدًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'What evidence supports that theory?',
              meaningAr: 'ما الدليل الذي يدعم تلك النظرية؟',
            ),
            choices: [
              'I am not entirely sure about that.',
              'What evidence supports that theory?',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We should consider another explanation.',
              meaningAr: 'ينبغي أن ندرس تفسيرًا آخر.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l25',
        title: 'The Empty Office',
        subtitle: 'Reconstruct a sequence',
        emoji: '🏢',
        color: ColorSeed.purple,
        xpReward: 55,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The lights were still on when we arrived.',
              meaningAr: 'كانت الأنوار لا تزال مضاءة عندما وصلنا.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The computer had been shut down.',
              meaningAr: 'كان الكمبيوتر قد أُغلق.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Nobody remembers seeing her leave.',
              meaningAr: 'لا يتذكر أحد أنه رآها تغادر.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'She might have left through the side entrance.',
              meaningAr: 'ربما غادرت عبر المدخل الجانبي.',
            ),
            choices: [
              'She might have left through the side entrance.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We need to separate facts from assumptions.',
              meaningAr: 'نحتاج إلى فصل الحقائق عن الافتراضات.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l26',
        title: 'Conflicting Stories',
        subtitle: 'Compare two accounts',
        emoji: '🗣️',
        color: ColorSeed.purple,
        xpReward: 57,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'His account differs from the witness\'s version.',
              meaningAr: 'تختلف روايته عن رواية الشاهد.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'She said she arrived after the alarm.',
              meaningAr: 'قالت إنها وصلت بعد الإنذار.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Both accounts cannot be completely accurate.',
              meaningAr: 'لا يمكن أن تكون الروايتان دقيقتين تمامًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Could either person have misunderstood the time?',
              meaningAr: 'هل يمكن أن يكون أحدهما قد أساء فهم الوقت؟',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Could either person have misunderstood the time?',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let\'s verify the timeline independently.',
              meaningAr: 'لنتحقق من التسلسل الزمني بشكل مستقل.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l27',
        title: 'The Unopened Letter',
        subtitle: 'Infer emotion and intent',
        emoji: '✉️',
        color: ColorSeed.purple,
        xpReward: 57,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The envelope had never been opened.',
              meaningAr: 'لم يُفتح الظرف قط.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'It had been addressed in unfamiliar handwriting.',
              meaningAr: 'كُتب العنوان بخط غير مألوف.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Perhaps the recipient was afraid of its contents.',
              meaningAr: 'ربما خاف المستلم مما بداخله.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'That is a possibility rather than a proven fact.',
              meaningAr: 'هذا احتمال وليس حقيقة مثبتة.',
            ),
            choices: [
              'That is a possibility rather than a proven fact.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The date may help us understand the context.',
              meaningAr: 'قد يساعدنا التاريخ على فهم السياق.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l28',
        title: 'A Room with No Exit',
        subtitle: 'Explain logical constraints',
        emoji: '🚪',
        color: ColorSeed.purple,
        xpReward: 57,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The only door was locked from the inside.',
              meaningAr: 'كان الباب الوحيد مغلقًا من الداخل.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The window was too narrow for an adult.',
              meaningAr: 'كانت النافذة أضيق من أن يمر منها شخص بالغ.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We may be missing an important detail.',
              meaningAr: 'ربما أغفلنا تفصيلًا مهمًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'An unusual explanation still needs evidence.',
              meaningAr: 'حتى التفسير غير المعتاد يحتاج إلى دليل.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'An unusual explanation still needs evidence.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let\'s test each possibility one by one.',
              meaningAr: 'لنختبر كل احتمال على حدة.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l29',
        title: 'The False Lead',
        subtitle: 'Revise an early assumption',
        emoji: '🧩',
        color: ColorSeed.purple,
        xpReward: 59,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'At first, the clue seemed conclusive.',
              meaningAr: 'بدا الدليل حاسمًا في البداية.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'New evidence has changed our understanding.',
              meaningAr: 'غيّر دليل جديد فهمنا.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Our original theory no longer fits the facts.',
              meaningAr: 'لم تعد نظريتنا الأولى تتوافق مع الحقائق.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'We should be willing to revise our view.',
              meaningAr: 'ينبغي أن نكون مستعدين لمراجعة رأينا.',
            ),
            choices: [
              'We should be willing to revise our view.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'A convincing story is not always a true one.',
              meaningAr: 'القصة المقنعة ليست صحيحة دائمًا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l30',
        title: 'Interview the Witness',
        subtitle: 'Ask precise follow-up questions',
        emoji: '🎙️',
        color: ColorSeed.purple,
        xpReward: 59,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'What exactly did you notice first?',
              meaningAr: 'ما الذي لاحظته تحديدًا أولًا؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'How far away were you standing?',
              meaningAr: 'كم كانت المسافة التي تقف عندها؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Could you see the person\'s face clearly?',
              meaningAr: 'هل استطعت رؤية وجه الشخص بوضوح؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Are you certain about the time?',
              meaningAr: 'هل أنت متأكد من الوقت؟',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Are you certain about the time?',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Is there anything else you remember?',
              meaningAr: 'هل تتذكر أي شيء آخر؟',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l31',
        title: 'Case Closed?',
        subtitle: 'Present a cautious conclusion',
        emoji: '📁',
        color: ColorSeed.purple,
        xpReward: 59,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The evidence points toward one likely explanation.',
              meaningAr: 'تشير الأدلة إلى تفسير مرجح.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'However, one important question remains unanswered.',
              meaningAr: 'ومع ذلك، لا يزال سؤال مهم بلا إجابة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We cannot rule out the alternative yet.',
              meaningAr: 'لا يمكننا استبعاد الاحتمال الآخر بعد.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The conclusion should reflect our uncertainty.',
              meaningAr: 'ينبغي أن يعكس الاستنتاج درجة عدم يقيننا.',
            ),
            choices: [
              'The conclusion should reflect our uncertainty.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'For now, the case remains open.',
              meaningAr: 'في الوقت الحالي، تظل القضية مفتوحة.',
            ),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u7',
    title: 'Unit 7 · Sound Lab',
    description: 'Improve clarity, rhythm, and listening confidence',
    lessons: [
      Lesson(
        id: 'l32',
        title: 'Word Stress',
        subtitle: 'Make important syllables clearer',
        emoji: '🔊',
        color: ColorSeed.green,
        xpReward: 60,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I need a comfortable place to work.',
              meaningAr: 'أحتاج إلى مكان مريح للعمل.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Could you explain the main point again?',
              meaningAr: 'هل يمكنك شرح النقطة الأساسية مجددًا؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I completely understand your concern.',
              meaningAr: 'أتفهم مخاوفك تمامًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The information was incredibly useful.',
              meaningAr: 'كانت المعلومات مفيدة للغاية.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'The information was incredibly useful.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let\'s focus on the most important detail.',
              meaningAr: 'لنركز على أهم تفصيل.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l33',
        title: 'Connected Speech',
        subtitle: 'Speak in natural groups',
        emoji: '〰️',
        color: ColorSeed.green,
        xpReward: 60,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Would you like to come along with us?',
              meaningAr: 'هل تود أن تأتي معنا؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I should have told you earlier.',
              meaningAr: 'كان ينبغي أن أخبرك في وقت أبكر.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'What are you planning to do tomorrow?',
              meaningAr: 'ماذا تخطط أن تفعل غدًا؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'We could have handled it differently.',
              meaningAr: 'كان بإمكاننا التعامل مع الأمر بطريقة مختلفة.',
            ),
            choices: [
              'We could have handled it differently.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I am going to give it another try.',
              meaningAr: 'سأحاول مرة أخرى.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l34',
        title: 'Similar Sounds',
        subtitle: 'Listen carefully to sound contrasts',
        emoji: '👂',
        color: ColorSeed.green,
        xpReward: 60,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Please leave the sheet on the desk.',
              meaningAr: 'من فضلك اترك الورقة على المكتب.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The ship arrived before sunset.',
              meaningAr: 'وصلت السفينة قبل غروب الشمس.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We need three clean glasses.',
              meaningAr: 'نحتاج إلى ثلاثة أكواب نظيفة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Those clothes are still wet.',
              meaningAr: 'تلك الملابس لا تزال مبللة.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Those clothes are still wet.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The price is slightly higher this year.',
              meaningAr: 'السعر أعلى قليلًا هذا العام.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l35',
        title: 'Sentence Rhythm',
        subtitle: 'Use pauses to support meaning',
        emoji: '🥁',
        color: ColorSeed.green,
        xpReward: 62,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Although it was raining, we continued walking.',
              meaningAr: 'رغم هطول المطر، واصلنا المشي.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'If you need any help, just let me know.',
              meaningAr: 'إذا احتجت إلى مساعدة، فأخبرني.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The report, which I sent yesterday, is attached.',
              meaningAr: 'التقرير الذي أرسلته أمس مرفق.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Before making a decision, consider the alternatives.',
              meaningAr: 'قبل اتخاذ قرار، فكّر في البدائل.',
            ),
            choices: [
              'Before making a decision, consider the alternatives.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'What matters most is how we respond.',
              meaningAr: 'الأهم هو كيفية استجابتنا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l36',
        title: 'Clear Endings',
        subtitle: 'Make final sounds audible',
        emoji: '🔚',
        color: ColorSeed.green,
        xpReward: 62,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'She works with international clients.',
              meaningAr: 'هي تعمل مع عملاء دوليين.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'He asked several difficult questions.',
              meaningAr: 'طرح عدة أسئلة صعبة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We finished the project last week.',
              meaningAr: 'أنهينا المشروع الأسبوع الماضي.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'They have already booked their seats.',
              meaningAr: 'لقد حجزوا مقاعدهم بالفعل.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'They have already booked their seats.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Please send the documents before Friday.',
              meaningAr: 'أرسل المستندات قبل الجمعة من فضلك.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l37',
        title: 'Speaking in Chunks',
        subtitle: 'Avoid word-by-word delivery',
        emoji: '🧱',
        color: ColorSeed.green,
        xpReward: 62,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'To be honest, I had a different impression.',
              meaningAr: 'بصراحة، كان لدي انطباع مختلف.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'As far as I can tell, everything is ready.',
              meaningAr: 'على حد علمي، كل شيء جاهز.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The good news is that we have more time.',
              meaningAr: 'الخبر الجيد هو أن لدينا مزيدًا من الوقت.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'From my point of view, it is worth trying.',
              meaningAr: 'من وجهة نظري، الأمر يستحق المحاولة.',
            ),
            choices: [
              'From my point of view, it is worth trying.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'What I find interesting is the final result.',
              meaningAr: 'ما أجده مثيرًا للاهتمام هو النتيجة النهائية.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l38',
        title: 'Listen for Meaning',
        subtitle: 'Catch key information',
        emoji: '📝',
        color: ColorSeed.green,
        xpReward: 64,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The meeting has been moved to Thursday afternoon.',
              meaningAr: 'نُقل الاجتماع إلى عصر الخميس.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Please bring the signed form and your identification.',
              meaningAr: 'أحضر النموذج الموقع وبطاقة هويتك.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The cheaper option takes slightly longer.',
              meaningAr: 'الخيار الأرخص يستغرق وقتًا أطول قليلًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'We will contact you once the results are ready.',
              meaningAr: 'سنتواصل معك عندما تصبح النتائج جاهزة.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'We will contact you once the results are ready.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The speaker disagreed with the final recommendation.',
              meaningAr: 'اختلف المتحدث مع التوصية النهائية.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l39',
        title: 'Repair a Misunderstanding',
        subtitle: 'Ask someone to clarify',
        emoji: '🔁',
        color: ColorSeed.green,
        xpReward: 64,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Sorry, I missed the last part of that.',
              meaningAr: 'عذرًا، لم أسمع الجزء الأخير.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Do you mean the meeting is postponed?',
              meaningAr: 'هل تقصد أن الاجتماع قد تأجل؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Let me rephrase that more clearly.',
              meaningAr: 'دعني أعيد صياغة ذلك بوضوح أكبر.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I may have misunderstood what you meant.',
              meaningAr: 'ربما أسأت فهم ما قصدته.',
            ),
            choices: [
              'I may have misunderstood what you meant.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Could you give me a quick example?',
              meaningAr: 'هل يمكنك إعطائي مثالًا سريعًا؟',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l40',
        title: 'Sound Check',
        subtitle: 'Combine pronunciation strategies',
        emoji: '🎚️',
        color: ColorSeed.green,
        xpReward: 64,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Clear communication is a skill we can develop.',
              meaningAr: 'التواصل الواضح مهارة يمكننا تطويرها.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I try to speak naturally rather than quickly.',
              meaningAr: 'أحاول التحدث بطبيعية بدلًا من السرعة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Pausing briefly can make a point more powerful.',
              meaningAr: 'قد يجعل التوقف القصير الفكرة أقوى.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I pay attention to stress and sentence rhythm.',
              meaningAr: 'أنتبه إلى النبر وإيقاع الجملة.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'I pay attention to stress and sentence rhythm.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Confidence grows when practice becomes a habit.',
              meaningAr: 'تزداد الثقة عندما تصبح الممارسة عادة.',
            ),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u8',
    title: 'Unit 8 · Choice & Consequence',
    description: 'Navigate conversations with tact',
    lessons: [
      Lesson(
        id: 'l41',
        title: 'A Difficult Request',
        subtitle: 'Set boundaries politely',
        emoji: '🧭',
        color: ColorSeed.orange,
        xpReward: 65,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I would like to help, but I have a deadline.',
              meaningAr: 'أود المساعدة، لكن لدي موعد تسليم.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Could we agree on a more realistic timeline?',
              meaningAr: 'هل يمكننا الاتفاق على جدول زمني أكثر واقعية؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I am not able to commit to that right now.',
              meaningAr: 'لا أستطيع الالتزام بذلك الآن.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'What if we divide the task between us?',
              meaningAr: 'ماذا لو قسمنا المهمة بيننا؟',
            ),
            choices: [
              'What if we divide the task between us?',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I appreciate you asking me.',
              meaningAr: 'أقدّر أنك طلبت مني ذلك.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l42',
        title: 'Giving Feedback',
        subtitle: 'Be honest and constructive',
        emoji: '🪴',
        color: ColorSeed.orange,
        xpReward: 65,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The main idea is strong, but the opening is unclear.',
              meaningAr: 'الفكرة الأساسية قوية، لكن المقدمة غير واضحة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'One improvement would be to add a concrete example.',
              meaningAr: 'من التحسينات الممكنة إضافة مثال ملموس.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I can see how much effort you put into this.',
              meaningAr: 'أرى مقدار الجهد الذي بذلته في هذا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Would you be open to a small suggestion?',
              meaningAr: 'هل تتقبل اقتراحًا صغيرًا؟',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Would you be open to a small suggestion?',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let\'s focus on what can be improved next.',
              meaningAr: 'لنركز على ما يمكن تحسينه لاحقًا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l43',
        title: 'Apologizing Well',
        subtitle: 'Take responsibility',
        emoji: '🤝',
        color: ColorSeed.orange,
        xpReward: 65,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I should have informed you sooner.',
              meaningAr: 'كان ينبغي أن أبلغك في وقت أبكر.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I understand why that caused frustration.',
              meaningAr: 'أتفهم سبب الإحباط الذي نتج عن ذلك.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I take responsibility for my part.',
              meaningAr: 'أتحمل مسؤولية الجزء الخاص بي.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Here is what I will do to put it right.',
              meaningAr: 'إليك ما سأفعله لتصحيح الأمر.',
            ),
            choices: [
              'Here is what I will do to put it right.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'It will not happen again without warning.',
              meaningAr: 'لن يتكرر الأمر دون تنبيه مسبق.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l44',
        title: 'Negotiating Plans',
        subtitle: 'Find a workable compromise',
        emoji: '🗓️',
        color: ColorSeed.orange,
        xpReward: 67,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Friday works for me, if we start early.',
              meaningAr: 'الجمعة مناسبة لي إذا بدأنا مبكرًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Would Saturday be a reasonable compromise?',
              meaningAr: 'هل سيكون السبت حلًا وسطًا مناسبًا؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I can be flexible about the location.',
              meaningAr: 'يمكنني المرونة بشأن المكان.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Let\'s identify what matters most to each of us.',
              meaningAr: 'لنحدد ما يهم كلًا منا أكثر.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Let\'s identify what matters most to each of us.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'That sounds fair to both sides.',
              meaningAr: 'يبدو ذلك عادلًا للطرفين.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l45',
        title: 'An Awkward Silence',
        subtitle: 'Keep a conversation moving',
        emoji: '☕',
        color: ColorSeed.orange,
        xpReward: 67,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'How did you first become interested in that?',
              meaningAr: 'كيف بدأ اهتمامك بذلك؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'What has been the highlight of your week?',
              meaningAr: 'ما أفضل ما حدث لك هذا الأسبوع؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I have been meaning to ask you about your project.',
              meaningAr: 'كنت أريد سؤالك عن مشروعك.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'That reminds me of something similar.',
              meaningAr: 'هذا يذكرني بشيء مشابه.',
            ),
            choices: [
              'That reminds me of something similar.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I\'d love to hear more about your experience.',
              meaningAr: 'أود سماع المزيد عن تجربتك.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l46',
        title: 'Disagreeing Respectfully',
        subtitle: 'Challenge ideas, not people',
        emoji: '⚖️',
        color: ColorSeed.orange,
        xpReward: 67,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I see your point, although I interpret the evidence differently.',
              meaningAr: 'أفهم وجهة نظرك، لكنني أفسر الأدلة بشكل مختلف.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Could there be another way to look at this?',
              meaningAr: 'هل يمكن النظر إلى الأمر بطريقة أخرى؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I agree with the goal, but not the proposed method.',
              meaningAr: 'أوافق على الهدف، لكن ليس على الطريقة المقترحة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'That is a fair concern to raise.',
              meaningAr: 'هذا تخوف وجيه يستحق الطرح.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'That is a fair concern to raise.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Perhaps we can find common ground.',
              meaningAr: 'ربما نستطيع إيجاد أرضية مشتركة.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l47',
        title: 'The Last-Minute Change',
        subtitle: 'Respond calmly to change',
        emoji: '🔄',
        color: ColorSeed.orange,
        xpReward: 69,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I have just heard that the venue has changed.',
              meaningAr: 'علمت للتو أن المكان قد تغير.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let\'s work out what this affects first.',
              meaningAr: 'لنحدد أولًا ما الذي سيتأثر بذلك.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I can adjust one part of the plan.',
              meaningAr: 'يمكنني تعديل جزء من الخطة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'We should tell everyone as soon as possible.',
              meaningAr: 'ينبغي إخبار الجميع في أقرب وقت.',
            ),
            choices: [
              'We should tell everyone as soon as possible.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Despite the change, we can still make it work.',
              meaningAr: 'رغم التغيير، لا يزال بإمكاننا إنجاح الأمر.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l48',
        title: 'Reading the Room',
        subtitle: 'Notice indirect signals',
        emoji: '👀',
        color: ColorSeed.orange,
        xpReward: 69,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'She seems hesitant to give a direct answer.',
              meaningAr: 'تبدو مترددة في إعطاء إجابة مباشرة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Perhaps now is not the best time to ask.',
              meaningAr: 'ربما ليس هذا أفضل وقت للسؤال.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'His tone sounded warmer than his words.',
              meaningAr: 'بدت نبرته أود من كلماته.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Let\'s check rather than assume what they feel.',
              meaningAr: 'لنتحقق بدلًا من افتراض مشاعرهم.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Let\'s check rather than assume what they feel.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'A little tact can prevent a bigger conflict.',
              meaningAr: 'يمكن لقليل من اللباقة منع خلاف أكبر.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l49',
        title: 'Branching Conversation',
        subtitle: 'Choose a response that moves things forward',
        emoji: '🌿',
        color: ColorSeed.orange,
        xpReward: 69,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I understand the concern; what outcome would help?',
              meaningAr: 'أتفهم القلق؛ ما النتيجة التي قد تساعد؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Would you prefer a quick solution or a lasting one?',
              meaningAr: 'هل تفضل حلًا سريعًا أم دائمًا؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Let\'s compare the trade-offs before deciding.',
              meaningAr: 'لنقارن المزايا والتنازلات قبل القرار.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I can accept that if we clarify the next steps.',
              meaningAr: 'يمكنني قبول ذلك إذا وضحنا الخطوات التالية.',
            ),
            choices: [
              'I can accept that if we clarify the next steps.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We have a plan, and we know who will do what.',
              meaningAr: 'لدينا خطة ونعرف مسؤولية كل شخص.',
            ),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u9',
    title: 'Unit 9 · Story Forge',
    description: 'Tell richer stories and express nuance',
    lessons: [
      Lesson(
        id: 'l50',
        title: 'Set the Scene',
        subtitle: 'Establish place and mood',
        emoji: '🌆',
        color: ColorSeed.purple,
        xpReward: 70,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'By the time we arrived, the streets were almost empty.',
              meaningAr: 'بحلول وصولنا، كانت الشوارع شبه خالية.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'A cold wind was blowing through the narrow alley.',
              meaningAr: 'كانت رياح باردة تهب عبر الزقاق الضيق.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'In the distance, a single light was flickering.',
              meaningAr: 'في البعيد، كان ضوء واحد يومض.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Everything seemed ordinary until the phone rang.',
              meaningAr: 'بدا كل شيء عاديًا حتى رن الهاتف.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Everything seemed ordinary until the phone rang.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I had no idea that the evening would change everything.',
              meaningAr: 'لم أكن أعلم أن المساء سيغير كل شيء.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l51',
        title: 'Build Suspense',
        subtitle: 'Control what the reader knows',
        emoji: '🕯️',
        color: ColorSeed.purple,
        xpReward: 70,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Something about his explanation did not add up.',
              meaningAr: 'كان هناك شيء غير منطقي في تفسيره.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Just as I was about to leave, I noticed the envelope.',
              meaningAr: 'بينما كنت على وشك المغادرة، لاحظت الظرف.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'She paused, as though choosing her words carefully.',
              meaningAr: 'توقفت وكأنها تختار كلماتها بعناية.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The silence that followed felt unusually long.',
              meaningAr: 'بدا الصمت الذي تلا ذلك طويلًا على نحو غير معتاد.',
            ),
            choices: [
              'The silence that followed felt unusually long.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Then I realized that the door had been open all along.',
              meaningAr: 'ثم أدركت أن الباب كان مفتوحًا طوال الوقت.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l52',
        title: 'Describe a Turning Point',
        subtitle: 'Show a change in direction',
        emoji: '↗️',
        color: ColorSeed.purple,
        xpReward: 70,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'That was the moment I began to question my decision.',
              meaningAr: 'كانت تلك اللحظة التي بدأت فيها التشكيك في قراري.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'What seemed like a setback became an opportunity.',
              meaningAr: 'ما بدا انتكاسة تحول إلى فرصة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I had to choose between comfort and honesty.',
              meaningAr: 'كان عليّ الاختيار بين الراحة والصدق.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Looking back, I can see why it mattered.',
              meaningAr: 'عند النظر إلى الماضي، أرى لماذا كان ذلك مهمًا.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Looking back, I can see why it mattered.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'From then on, nothing felt quite the same.',
              meaningAr: 'منذ ذلك الحين، لم يعد شيء كما كان تمامًا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l53',
        title: 'Tell It Another Way',
        subtitle: 'Paraphrase without losing meaning',
        emoji: '🔀',
        color: ColorSeed.purple,
        xpReward: 72,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'In other words, we need more time to prepare.',
              meaningAr: 'بعبارة أخرى، نحتاج إلى مزيد من الوقت للاستعداد.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'What I am trying to say is that the plan needs work.',
              meaningAr: 'ما أحاول قوله هو أن الخطة تحتاج إلى تحسين.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'To put it differently, the risk is still too high.',
              meaningAr: 'بصياغة أخرى، لا تزال المخاطرة مرتفعة جدًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The point is not that we failed, but that we learned.',
              meaningAr: 'ليس المقصود أننا فشلنا، بل أننا تعلمنا.',
            ),
            choices: [
              'The point is not that we failed, but that we learned.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'In short, the evidence does not support that claim.',
              meaningAr: 'باختصار، لا تدعم الأدلة ذلك الادعاء.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l54',
        title: 'Character and Motive',
        subtitle: 'Explain why someone acts',
        emoji: '🎭',
        color: ColorSeed.purple,
        xpReward: 72,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'He acted as though he had nothing to lose.',
              meaningAr: 'تصرف كما لو أنه لا يملك ما يخسره.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'She was reluctant to admit how worried she was.',
              meaningAr: 'ترددت في الاعتراف بمدى قلقها.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'His generosity seemed genuine rather than strategic.',
              meaningAr: 'بدت كرماته صادقة لا محسوبة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I suspect she wanted to protect someone.',
              meaningAr: 'أظن أنها أرادت حماية شخص ما.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'I suspect she wanted to protect someone.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Their actions revealed more than their promises.',
              meaningAr: 'كشفت أفعالهم أكثر مما كشفت وعودهم.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l55',
        title: 'Use Precise Details',
        subtitle: 'Replace vague language',
        emoji: '🔍',
        color: ColorSeed.purple,
        xpReward: 72,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The room smelled faintly of rain and old paper.',
              meaningAr: 'كانت رائحة المطر والورق القديم تفوح من الغرفة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'He answered after a brief but uncomfortable pause.',
              meaningAr: 'أجاب بعد توقف قصير لكنه محرج.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The glass trembled as the train passed.',
              meaningAr: 'اهتز الزجاج بينما مر القطار.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Her voice grew quieter with every sentence.',
              meaningAr: 'أصبح صوتها أخفض مع كل جملة.',
            ),
            choices: [
              'Her voice grew quieter with every sentence.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'A small detail made the entire scene believable.',
              meaningAr: 'جعل تفصيل صغير المشهد كله قابلًا للتصديق.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l56',
        title: 'Cause and Effect',
        subtitle: 'Connect events logically',
        emoji: '🔗',
        color: ColorSeed.purple,
        xpReward: 74,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Because the evidence was incomplete, we delayed the decision.',
              meaningAr: 'لأن الأدلة لم تكن مكتملة، أجلنا القرار.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The delay meant that we had to change our approach.',
              meaningAr: 'يعني التأخير أننا اضطررنا لتغيير نهجنا.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Had we checked earlier, we might have avoided the problem.',
              meaningAr: 'لو تحققنا مبكرًا، لربما تجنبنا المشكلة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'As a result, the team became more cautious.',
              meaningAr: 'ونتيجة لذلك، أصبح الفريق أكثر حذرًا.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'As a result, the team became more cautious.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'This experience taught us to plan for uncertainty.',
              meaningAr: 'علمتنا هذه التجربة التخطيط لعدم اليقين.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l57',
        title: 'Narrative Perspective',
        subtitle: 'Shift the point of view',
        emoji: '👁️',
        color: ColorSeed.purple,
        xpReward: 74,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'From her perspective, the decision seemed inevitable.',
              meaningAr: 'من وجهة نظرها، بدا القرار حتميًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I only learned the truth years later.',
              meaningAr: 'لم أعرف الحقيقة إلا بعد سنوات.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'At the time, none of us understood the consequences.',
              meaningAr: 'في ذلك الوقت، لم يفهم أي منا العواقب.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'What I remember most clearly is the sound of footsteps.',
              meaningAr: 'أكثر ما أتذكره بوضوح هو صوت الخطوات.',
            ),
            choices: [
              'What I remember most clearly is the sound of footsteps.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'If he had told the story, he might have described it differently.',
              meaningAr: 'لو روى هو القصة، لربما وصفها بشكل مختلف.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l58',
        title: 'Final Story',
        subtitle: 'Bring a story to a meaningful close',
        emoji: '🏁',
        color: ColorSeed.purple,
        xpReward: 74,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'In the end, the answer was simpler than we expected.',
              meaningAr: 'في النهاية، كانت الإجابة أبسط مما توقعنا.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We never discovered who had left the note.',
              meaningAr: 'لم نكتشف أبدًا من ترك الملاحظة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Some questions remained, but the fear had passed.',
              meaningAr: 'بقيت بعض الأسئلة، لكن الخوف زال.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I realized that the journey had changed me.',
              meaningAr: 'أدركت أن الرحلة قد غيرتني.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'I realized that the journey had changed me.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'And that is why I still remember that night.',
              meaningAr: 'ولهذا ما زلت أتذكر تلك الليلة.',
            ),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u10',
    title: 'Unit 10 · Debate Arena',
    description: 'Build arguments and evaluate evidence',
    lessons: [
      Lesson(
        id: 'l59',
        title: 'Make a Clear Claim',
        subtitle: 'State and qualify an argument',
        emoji: '📣',
        color: ColorSeed.orange,
        xpReward: 75,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'My main argument is that access matters more than convenience.',
              meaningAr: 'حجتي الأساسية أن إمكانية الوصول أهم من الراحة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'This claim depends on how we define success.',
              meaningAr: 'يعتمد هذا الادعاء على كيفية تعريف النجاح.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The strongest evidence in favor is the long-term result.',
              meaningAr: 'أقوى دليل مؤيد هو النتيجة طويلة المدى.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'We should distinguish correlation from causation.',
              meaningAr: 'ينبغي التمييز بين الارتباط والسببية.',
            ),
            choices: [
              'We should distinguish correlation from causation.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I would qualify that conclusion in one important respect.',
              meaningAr: 'سأقيّد ذلك الاستنتاج من ناحية مهمة.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l60',
        title: 'Support with Evidence',
        subtitle: 'Explain why a claim is credible',
        emoji: '📊',
        color: ColorSeed.orange,
        xpReward: 75,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The data supports the trend, though not every case.',
              meaningAr: 'تدعم البيانات الاتجاه، وإن لم تدعم كل حالة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'A concrete example helps illustrate the mechanism.',
              meaningAr: 'يساعد مثال ملموس على توضيح الآلية.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We need to know how the sample was selected.',
              meaningAr: 'نحتاج إلى معرفة كيفية اختيار العينة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'That source is useful, but it has clear limitations.',
              meaningAr: 'هذا المصدر مفيد، لكنه محدود بوضوح.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'That source is useful, but it has clear limitations.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The conclusion should not go beyond the evidence.',
              meaningAr: 'ينبغي ألا يتجاوز الاستنتاج الأدلة المتاحة.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l61',
        title: 'Counterarguments',
        subtitle: 'Address the strongest objection',
        emoji: '🥊',
        color: ColorSeed.orange,
        xpReward: 75,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'A reasonable objection is that the costs may be too high.',
              meaningAr: 'اعتراض معقول هو أن التكاليف قد تكون مرتفعة جدًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'That concern is valid, but it is not decisive.',
              meaningAr: 'هذا التخوف وجيه، لكنه ليس حاسمًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The opposing view overlooks one practical constraint.',
              meaningAr: 'يغفل الرأي المعارض قيدًا عمليًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Even so, we should acknowledge the trade-off.',
              meaningAr: 'ومع ذلك، ينبغي الاعتراف بالمقايضة.',
            ),
            choices: [
              'Even so, we should acknowledge the trade-off.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'A stronger version of the objection would be this.',
              meaningAr: 'يمكن صياغة الاعتراض بصورة أقوى هكذا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l62',
        title: 'Avoid Logical Traps',
        subtitle: 'Spot weak reasoning',
        emoji: '🧠',
        color: ColorSeed.orange,
        xpReward: 77,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'One example does not establish a general rule.',
              meaningAr: 'لا يثبت مثال واحد قاعدة عامة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The argument assumes what it needs to prove.',
              meaningAr: 'تفترض الحجة ما تحتاج إلى إثباته.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Those two events may share a cause.',
              meaningAr: 'قد يكون للحدثين سبب مشترك.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The absence of evidence is not always evidence of absence.',
              meaningAr: 'غياب الدليل ليس دائمًا دليلًا على الغياب.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'The absence of evidence is not always evidence of absence.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We should compare the alternatives fairly.',
              meaningAr: 'ينبغي مقارنة البدائل بإنصاف.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l63',
        title: 'Weigh the Evidence',
        subtitle: 'Compare competing explanations',
        emoji: '⚖️',
        color: ColorSeed.orange,
        xpReward: 77,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'This explanation accounts for more of the available facts.',
              meaningAr: 'يفسر هذا التفسير عددًا أكبر من الحقائق المتاحة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The alternative is simpler, but less comprehensive.',
              meaningAr: 'البديل أبسط لكنه أقل شمولًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We should consider how likely each explanation is.',
              meaningAr: 'ينبغي النظر في مدى احتمال كل تفسير.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'A single exception may weaken, but not destroy, the pattern.',
              meaningAr: 'قد يضعف استثناء واحد النمط دون أن يلغيه.',
            ),
            choices: [
              'A single exception may weaken, but not destroy, the pattern.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'For now, the balance of evidence favors the first view.',
              meaningAr: 'حتى الآن، ترجح كفة الأدلة الرأي الأول.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l64',
        title: 'Persuade an Audience',
        subtitle: 'Adapt language to your listeners',
        emoji: '🎤',
        color: ColorSeed.orange,
        xpReward: 77,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The practical benefit is what matters most here.',
              meaningAr: 'الفائدة العملية هي الأهم هنا.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let me illustrate that with a familiar example.',
              meaningAr: 'دعني أوضح ذلك بمثال مألوف.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'You do not have to agree with every detail.',
              meaningAr: 'ليس عليك الموافقة على كل تفصيل.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Consider what would happen if we did nothing.',
              meaningAr: 'فكر فيما قد يحدث إذا لم نفعل شيئًا.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Consider what would happen if we did nothing.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The choice ultimately depends on our priorities.',
              meaningAr: 'يعتمد الاختيار في النهاية على أولوياتنا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l65',
        title: 'Ethical Dilemmas',
        subtitle: 'Balance competing values',
        emoji: '🧭',
        color: ColorSeed.orange,
        xpReward: 79,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The decision protects privacy but reduces transparency.',
              meaningAr: 'يحمي القرار الخصوصية لكنه يقلل الشفافية.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'There is no option without a meaningful cost.',
              meaningAr: 'لا يوجد خيار بلا تكلفة حقيقية.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We need to ask who bears most of the risk.',
              meaningAr: 'نحتاج إلى السؤال عمن يتحمل معظم المخاطر.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'A fair solution should explain its guiding principles.',
              meaningAr: 'ينبغي للحل العادل توضيح المبادئ التي توجهه.',
            ),
            choices: [
              'A fair solution should explain its guiding principles.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The right answer may depend on the circumstances.',
              meaningAr: 'قد تعتمد الإجابة الصحيحة على الظروف.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l66',
        title: 'Debate Under Pressure',
        subtitle: 'Respond without losing precision',
        emoji: '⏱️',
        color: ColorSeed.orange,
        xpReward: 79,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Let me address the central point directly.',
              meaningAr: 'دعني أتناول النقطة الأساسية مباشرة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'That conclusion does not follow from the premise.',
              meaningAr: 'لا ينتج ذلك الاستنتاج عن المقدمة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I agree with the observation, not the interpretation.',
              meaningAr: 'أوافق على الملاحظة لا على التفسير.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'We are using the same term in different ways.',
              meaningAr: 'نستخدم المصطلح نفسه بمعنيين مختلفين.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'We are using the same term in different ways.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I will revise my position if stronger evidence emerges.',
              meaningAr: 'سأراجع موقفي إذا ظهرت أدلة أقوى.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l67',
        title: 'Closing Statement',
        subtitle: 'Summarize a balanced position',
        emoji: '🏆',
        color: ColorSeed.orange,
        xpReward: 79,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The evidence is mixed, but a cautious conclusion is possible.',
              meaningAr: 'الأدلة متباينة، لكن يمكن الوصول إلى استنتاج حذر.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The benefits are substantial if the safeguards work.',
              meaningAr: 'الفوائد كبيرة إذا نجحت الضمانات.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The strongest objection remains unresolved.',
              meaningAr: 'لا يزال أقوى اعتراض بلا حل.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'On balance, I support the proposal with conditions.',
              meaningAr: 'في المحصلة، أؤيد المقترح بشروط.',
            ),
            choices: [
              'On balance, I support the proposal with conditions.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'That is the position I can defend with the evidence available.',
              meaningAr: 'هذا هو الموقف الذي أستطيع الدفاع عنه بالأدلة المتاحة.',
            ),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u11',
    title: 'Unit 11 · Language Mastery',
    description: 'Express subtle meaning with precision',
    lessons: [
      Lesson(
        id: 'l68',
        title: 'Implied Meaning',
        subtitle: 'Read between the lines',
        emoji: '🕵️',
        color: ColorSeed.blue,
        xpReward: 80,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'That is certainly one way to approach the problem.',
              meaningAr: 'هذا بالتأكيد أحد أساليب التعامل مع المشكلة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I would not call the timing ideal.',
              meaningAr: 'لن أصف التوقيت بأنه مثالي.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Some aspects of the proposal deserve further thought.',
              meaningAr: 'تستحق بعض جوانب المقترح مزيدًا من التفكير.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Her response was polite, though noticeably brief.',
              meaningAr: 'كان ردها مهذبًا لكنه مقتضب بشكل ملحوظ.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Her response was polite, though noticeably brief.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The wording leaves room for more than one interpretation.',
              meaningAr: 'تترك الصياغة مجالًا لأكثر من تفسير.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l69',
        title: 'Register and Tone',
        subtitle: 'Choose language for context',
        emoji: '🎩',
        color: ColorSeed.blue,
        xpReward: 80,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Could you possibly clarify the intended outcome?',
              meaningAr: 'هل يمكنك توضيح النتيجة المقصودة؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I am writing to enquire about the advertised position.',
              meaningAr: 'أكتب للاستفسار عن الوظيفة المعلن عنها.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'That approach strikes me as unnecessarily confrontational.',
              meaningAr: 'يبدو لي هذا النهج تصادميًا دون داعٍ.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'We would be grateful for your prompt response.',
              meaningAr: 'سنكون ممتنين لردكم السريع.',
            ),
            choices: [
              'We would be grateful for your prompt response.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let\'s keep the discussion constructive and focused.',
              meaningAr: 'لنجعل النقاش بنّاءً ومركزًا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l70',
        title: 'Hedging Carefully',
        subtitle: 'Show the right degree of certainty',
        emoji: '🌫️',
        color: ColorSeed.blue,
        xpReward: 80,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The findings appear to suggest a modest improvement.',
              meaningAr: 'يبدو أن النتائج تشير إلى تحسن محدود.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'It is plausible, although the evidence is inconclusive.',
              meaningAr: 'هذا احتمال معقول، رغم أن الأدلة غير حاسمة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We cannot entirely discount that possibility.',
              meaningAr: 'لا يمكننا استبعاد هذا الاحتمال تمامًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The pattern may be partly explained by external factors.',
              meaningAr: 'قد تفسر العوامل الخارجية هذا النمط جزئيًا.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'The pattern may be partly explained by external factors.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I would be reluctant to draw a firm conclusion yet.',
              meaningAr: 'سأتردد في استخلاص نتيجة قاطعة الآن.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l71',
        title: 'Nuanced Vocabulary',
        subtitle: 'Choose the most accurate word',
        emoji: '🧩',
        color: ColorSeed.blue,
        xpReward: 82,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The distinction is subtle but consequential.',
              meaningAr: 'التمييز دقيق لكنه مؤثر.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Her criticism was measured rather than dismissive.',
              meaningAr: 'كان نقدها متزنًا لا رافضًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The proposal is feasible, provided funding is secured.',
              meaningAr: 'المقترح قابل للتنفيذ بشرط تأمين التمويل.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'His account was consistent with the available records.',
              meaningAr: 'توافقت روايته مع السجلات المتاحة.',
            ),
            choices: [
              'His account was consistent with the available records.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The outcome was unexpected, though not implausible.',
              meaningAr: 'كانت النتيجة غير متوقعة لكنها ليست مستبعدة.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l72',
        title: 'Complex Sentence Control',
        subtitle: 'Express relationships clearly',
        emoji: '🧵',
        color: ColorSeed.blue,
        xpReward: 82,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'While the evidence is limited, the trend is worth examining.',
              meaningAr: 'رغم محدودية الأدلة، يستحق الاتجاه الدراسة.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'What matters is not whether the plan is ambitious, but whether it is workable.',
              meaningAr: 'المهم ليس طموح الخطة، بل قابليتها للتنفيذ.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The report, having considered several alternatives, recommends a phased approach.',
              meaningAr: 'يوصي التقرير، بعد دراسة عدة بدائل، بنهج مرحلي.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Were the assumptions to change, the result might differ.',
              meaningAr: 'لو تغيرت الافتراضات، فقد تختلف النتيجة.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'Were the assumptions to change, the result might differ.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The more carefully we define the problem, the easier it becomes to solve.',
              meaningAr: 'كلما حددنا المشكلة بعناية، أصبح حلها أسهل.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l73',
        title: 'Summarize Complex Ideas',
        subtitle: 'Keep the central meaning',
        emoji: '📄',
        color: ColorSeed.blue,
        xpReward: 82,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'In essence, the proposal trades speed for greater reliability.',
              meaningAr: 'في جوهره، يستبدل المقترح السرعة بموثوقية أكبر.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The report identifies a gap between policy and practice.',
              meaningAr: 'يحدد التقرير فجوة بين السياسة والتطبيق.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The key limitation is the lack of long-term evidence.',
              meaningAr: 'القيد الأساسي هو غياب الأدلة طويلة الأجل.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Taken together, the results support a cautious interpretation.',
              meaningAr: 'تدعم النتائج مجتمعة تفسيرًا حذرًا.',
            ),
            choices: [
              'Taken together, the results support a cautious interpretation.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The details differ, but the underlying principle is shared.',
              meaningAr: 'تختلف التفاصيل، لكن المبدأ الأساسي مشترك.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l74',
        title: 'Precision in Disagreement',
        subtitle: 'Qualify criticism accurately',
        emoji: '🎯',
        color: ColorSeed.blue,
        xpReward: 84,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I question the assumption rather than the overall objective.',
              meaningAr: 'أشكك في الافتراض لا في الهدف العام.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The evidence is insufficient to justify that stronger claim.',
              meaningAr: 'الأدلة غير كافية لتبرير هذا الادعاء الأقوى.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'That is partly true, but it omits an important condition.',
              meaningAr: 'هذا صحيح جزئيًا، لكنه يغفل شرطًا مهمًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I would distinguish the immediate effect from the long-term impact.',
              meaningAr: 'سأميز بين الأثر الفوري والتأثير طويل الأجل.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'I would distinguish the immediate effect from the long-term impact.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Our disagreement may concern definitions more than facts.',
              meaningAr: 'قد يتعلق خلافنا بالتعريفات أكثر من الحقائق.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l75',
        title: 'Idiomatic Fluency',
        subtitle: 'Use natural expressions appropriately',
        emoji: '💬',
        color: ColorSeed.blue,
        xpReward: 84,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We need to get to the bottom of this.',
              meaningAr: 'نحتاج إلى كشف حقيقة الأمر.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'That plan sounds good on paper.',
              meaningAr: 'تبدو تلك الخطة جيدة نظريًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I do not want to jump to conclusions.',
              meaningAr: 'لا أريد التسرع في الاستنتاج.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Let\'s keep the bigger picture in mind.',
              meaningAr: 'لنبقِ الصورة الأكبر في أذهاننا.',
            ),
            choices: [
              'Let\'s keep the bigger picture in mind.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The issue has been blown out of proportion.',
              meaningAr: 'تم تضخيم المشكلة أكثر من اللازم.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l76',
        title: 'Mastery Check',
        subtitle: 'Integrate accuracy, tone, and nuance',
        emoji: '🏅',
        color: ColorSeed.blue,
        xpReward: 84,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The available evidence lends some support to that interpretation.',
              meaningAr: 'تقدم الأدلة المتاحة بعض الدعم لذلك التفسير.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I would frame the conclusion more cautiously.',
              meaningAr: 'سأصوغ الاستنتاج بحذر أكبر.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The distinction is relevant, but not sufficient on its own.',
              meaningAr: 'هذا التمييز مهم لكنه غير كافٍ بمفرده.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'A more balanced assessment would consider both outcomes.',
              meaningAr: 'سيأخذ التقييم الأكثر توازنًا النتيجتين في الاعتبار.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'A more balanced assessment would consider both outcomes.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The conclusion should remain open to revision.',
              meaningAr: 'ينبغي أن يظل الاستنتاج قابلًا للمراجعة.',
            ),
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u12',
    title: 'Unit 12 · The C1 Expedition',
    description: 'Combine advanced skills in a final challenge',
    lessons: [
      Lesson(
        id: 'l77',
        title: 'Research Briefing',
        subtitle: 'Explain findings with appropriate caution',
        emoji: '🔬',
        color: ColorSeed.green,
        xpReward: 85,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The preliminary findings warrant further investigation.',
              meaningAr: 'تستدعي النتائج الأولية مزيدًا من البحث.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The sample is too limited to support broad generalizations.',
              meaningAr: 'العينة محدودة أكثر من اللازم لدعم تعميمات واسعة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Several plausible explanations remain under consideration.',
              meaningAr: 'لا تزال عدة تفسيرات معقولة قيد الدراسة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The report distinguishes observed outcomes from projected ones.',
              meaningAr: 'يميز التقرير بين النتائج المرصودة والمتوقعة.',
            ),
            choices: [
              'The report distinguishes observed outcomes from projected ones.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Our recommendations reflect both the evidence and its limitations.',
              meaningAr: 'تعكس توصياتنا الأدلة وحدودها معًا.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l78',
        title: 'Lead a Meeting',
        subtitle: 'Guide a group toward a decision',
        emoji: '🧑‍💼',
        color: ColorSeed.green,
        xpReward: 85,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Before we move on, are there any outstanding concerns?',
              meaningAr: 'قبل أن ننتقل، هل توجد مخاوف لم تُحسم؟',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let\'s separate the urgent items from the important ones.',
              meaningAr: 'لنميز الأمور العاجلة عن الأمور المهمة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Could we hear from someone who has not spoken yet?',
              meaningAr: 'هل يمكننا الاستماع إلى شخص لم يتحدث بعد؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I suggest we record the decision and its rationale.',
              meaningAr: 'أقترح تسجيل القرار وأسبابه.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'I suggest we record the decision and its rationale.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We have enough information to agree on the next step.',
              meaningAr: 'لدينا معلومات كافية للاتفاق على الخطوة التالية.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l79',
        title: 'Handle a Crisis',
        subtitle: 'Communicate clearly under pressure',
        emoji: '🚨',
        color: ColorSeed.green,
        xpReward: 85,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Our immediate priority is to establish what happened.',
              meaningAr: 'أولويتنا الفورية هي تحديد ما حدث.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Please rely on confirmed information rather than speculation.',
              meaningAr: 'اعتمدوا على المعلومات المؤكدة بدلًا من التكهنات.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We will issue an update as soon as we can verify the facts.',
              meaningAr: 'سنصدر تحديثًا فور التحقق من الحقائق.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'The situation is serious, but the response is coordinated.',
              meaningAr: 'الوضع خطير، لكن الاستجابة منسقة.',
            ),
            choices: [
              'The situation is serious, but the response is coordinated.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'We need a clear record of every action taken.',
              meaningAr: 'نحتاج إلى سجل واضح لكل إجراء اتُخذ.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l80',
        title: 'Mediate a Dispute',
        subtitle: 'Find common ground between positions',
        emoji: '🕊️',
        color: ColorSeed.green,
        xpReward: 87,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Each side has raised a concern that deserves consideration.',
              meaningAr: 'طرح كل طرف تخوفًا يستحق النظر.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Could you identify the outcome you both want?',
              meaningAr: 'هل يمكنكما تحديد النتيجة التي تريدانها معًا؟',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The disagreement seems to center on the process.',
              meaningAr: 'يبدو أن الخلاف يتمحور حول الإجراءات.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'A workable compromise may preserve the core priorities.',
              meaningAr: 'قد يحافظ حل وسط عملي على الأولويات الأساسية.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'A workable compromise may preserve the core priorities.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Let\'s confirm what each party is willing to accept.',
              meaningAr: 'لنتأكد مما يقبل به كل طرف.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l81',
        title: 'Present a Proposal',
        subtitle: 'Make a structured case',
        emoji: '📈',
        color: ColorSeed.green,
        xpReward: 87,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'The proposal addresses the problem in three stages.',
              meaningAr: 'يعالج المقترح المشكلة على ثلاث مراحل.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The expected benefit outweighs the initial implementation cost.',
              meaningAr: 'تفوق الفائدة المتوقعة تكلفة التنفيذ الأولية.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We have included safeguards against the main risks.',
              meaningAr: 'أدرجنا ضمانات ضد المخاطر الرئيسية.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Success will depend on transparent evaluation.',
              meaningAr: 'سيعتمد النجاح على التقييم الشفاف.',
            ),
            choices: [
              'Success will depend on transparent evaluation.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I welcome scrutiny of the assumptions behind this plan.',
              meaningAr: 'أرحب بفحص الافتراضات التي تقوم عليها هذه الخطة.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l82',
        title: 'Respond to Criticism',
        subtitle: 'Separate useful feedback from tone',
        emoji: '🛡️',
        color: ColorSeed.green,
        xpReward: 87,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'That criticism highlights a weakness we should address.',
              meaningAr: 'يسلط هذا النقد الضوء على نقطة ضعف ينبغي معالجتها.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'I agree with the concern, though not every implication.',
              meaningAr: 'أوافق على التخوف، وإن لم أوافق على كل ما يترتب عليه.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Could you point to the specific evidence behind that claim?',
              meaningAr: 'هل يمكنك الإشارة إلى الدليل المحدد وراء هذا الادعاء؟',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'We should revise the plan where the criticism is justified.',
              meaningAr: 'ينبغي تعديل الخطة حيث يكون النقد مبررًا.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'We should revise the plan where the criticism is justified.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The objective is improvement, not defending every detail.',
              meaningAr: 'الهدف هو التحسين، لا الدفاع عن كل تفصيل.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l83',
        title: 'Synthesize Perspectives',
        subtitle: 'Combine insights without flattening differences',
        emoji: '🧬',
        color: ColorSeed.green,
        xpReward: 89,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'Both accounts capture part of a more complicated picture.',
              meaningAr: 'تلتقط الروايتان جزءًا من صورة أكثر تعقيدًا.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The common ground is narrower, but still meaningful.',
              meaningAr: 'نقاط الاتفاق أضيق لكنها لا تزال مهمة.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'These findings complement one another rather than conflict.',
              meaningAr: 'تكمل هذه النتائج بعضها بعضًا بدلًا من التعارض.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'A synthesis should preserve the strongest point from each view.',
              meaningAr: 'ينبغي أن يحافظ التركيب على أقوى نقطة في كل رأي.',
            ),
            choices: [
              'A synthesis should preserve the strongest point from each view.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The remaining tension cannot be resolved by wording alone.',
              meaningAr: 'لا يمكن حل التوتر المتبقي بمجرد تغيير الصياغة.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l84',
        title: 'Reflect and Refine',
        subtitle: 'Evaluate your own communication',
        emoji: '🪞',
        color: ColorSeed.green,
        xpReward: 89,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I could have made the central point more explicit.',
              meaningAr: 'كان بإمكاني توضيح الفكرة الأساسية بصورة أكبر.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'My wording may have sounded more certain than I intended.',
              meaningAr: 'ربما بدت صياغتي أكثر يقينًا مما قصدت.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'A better example would have made the distinction clearer.',
              meaningAr: 'كان مثال أفضل سيجعل التمييز أوضح.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'I should check understanding before moving forward.',
              meaningAr: 'ينبغي أن أتحقق من الفهم قبل المتابعة.',
            ),
            choices: [
              'I am not entirely sure about that.',
              'I should check understanding before moving forward.',
              'Could you explain that another way?',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'Reflection helps turn experience into deliberate practice.',
              meaningAr: 'يساعد التأمل على تحويل الخبرة إلى ممارسة واعية.',
            ),
          ),
        ],
      ),
      Lesson(
        id: 'l85',
        title: 'Expedition Finale',
        subtitle: 'Demonstrate integrated advanced communication',
        emoji: '🏁',
        color: ColorSeed.green,
        xpReward: 89,
        exercises: [
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'I will present the conclusion, the caveats, and the next steps.',
              meaningAr: 'سأعرض الاستنتاج والتحفظات والخطوات التالية.',
            ),
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The strongest position is the one that survives careful scrutiny.',
              meaningAr: 'أقوى موقف هو الذي يصمد أمام الفحص الدقيق.',
            ),
          ),
          Exercise(
            type: ExerciseType.listenRepeat,
            phrase: Phrase(
              text: 'We should act decisively while remaining open to new evidence.',
              meaningAr: 'ينبغي أن نتصرف بحزم مع الانفتاح على أدلة جديدة.',
            ),
          ),
          Exercise(
            type: ExerciseType.chooseAndSay,
            phrase: Phrase(
              text: 'Clear communication makes complex decisions more manageable.',
              meaningAr: 'يجعل التواصل الواضح القرارات المعقدة أسهل في التعامل.',
            ),
            choices: [
              'Clear communication makes complex decisions more manageable.',
              'Could you explain that another way?',
              'I am not entirely sure about that.',
            ],
          ),
          Exercise(
            type: ExerciseType.speakPrompt,
            phrase: Phrase(
              text: 'The goal is not flawless speech, but precise and effective meaning.',
              meaningAr: 'الهدف ليس الكلام الخالي من العيوب، بل المعنى الدقيق والفعال.',
            ),
          ),
        ],
      ),
    ],
  ),
];

Lesson? findLesson(String id) {
  for (final unit in curriculum) {
    for (final lesson in unit.lessons) {
      if (lesson.id == id) return lesson;
    }
  }
  return null;
}

List<Lesson> allLessons() =>
    curriculum.expand((u) => u.lessons).toList(growable: false);
