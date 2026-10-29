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
