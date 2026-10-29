#!/usr/bin/env python3
"""Safely expand SpeakLocal curriculum from 4 units / 13 lessons to 12 / 85.

Run from Kali:
  python3 expand_speaklocal.py
The script keeps a timestamped copy of each file it changes and refuses to
run twice. It preserves existing lesson IDs and the progress storage schema.
"""
from pathlib import Path
from datetime import datetime
import re
import shutil
import sys

ROOT = Path.home() / "Videos" / "Final_Project_Speak"
LESSONS = ROOT / "lib/data/lessons.dart"
MODEL = ROOT / "lib/models/lesson.dart"

if not ROOT.is_dir() or not LESSONS.is_file() or not MODEL.is_file():
    sys.exit(f"Project files not found under {ROOT}. Edit ROOT in this script if needed.")

src = LESSONS.read_text(encoding="utf-8")
model = MODEL.read_text(encoding="utf-8")

if "id: 'u12'" in src or "id: 'l85'" in src:
    sys.exit("Expansion markers already exist. No files changed.")
if "enum ExerciseType { listenRepeat, speakPrompt, chooseAndSay }" not in model:
    sys.exit("Unexpected lesson model. No files changed; inspect lib/models/lesson.dart first.")
if "id: 'u4'" not in src or "id: 'l13'" not in src:
    sys.exit("Expected original curriculum (u1-u4, l1-l13) was not found. No files changed.")

# New lesson content: title, subtitle, emoji, color, five target phrases with Arabic meanings.
units = [
("The Living City", "Handle real-life situations around town", "🏙️", "blue", [
("Finding Your Way","Ask for and understand directions","🧭",[
("Could you tell me how to get to the museum?","هل يمكنك أن تخبرني كيف أصل إلى المتحف؟"),
("Go straight until you reach the bridge.","سر مباشرة حتى تصل إلى الجسر."),
("Turn left at the traffic lights.","انعطف يسارًا عند إشارة المرور."),
("Is it within walking distance?","هل يمكن الوصول إليه سيرًا؟"),
("I think we have taken the wrong street.","أعتقد أننا سلكنا الشارع الخطأ.")]),
("At the Pharmacy","Explain a simple need","💊",[
("I have a sore throat.","أعاني من التهاب في الحلق."),
("Do you have anything for a headache?","هل لديكم شيء للصداع؟"),
("How often should I take this?","كم مرة ينبغي أن أتناول هذا؟"),
("Are there any side effects?","هل توجد آثار جانبية؟"),
("I will check with a pharmacist first.","سأستشير الصيدلي أولًا.")]),
("Making a Complaint","Describe a problem politely","🛠️",[
("There seems to be a problem with my order.","يبدو أن هناك مشكلة في طلبي."),
("I am afraid this is not what I asked for.","أخشى أن هذا ليس ما طلبته."),
("Could you look into this, please?","هل يمكنك التحقق من الأمر من فضلك؟"),
("I would appreciate a replacement.","سأقدّر توفير بديل."),
("Thank you for helping me sort this out.","شكرًا لمساعدتي في حل هذه المشكلة.")]),
("Public Transport","Travel across the city","🚌",[
("Does this bus stop near the university?","هل تتوقف هذه الحافلة بالقرب من الجامعة؟"),
("Where can I top up my travel card?","أين يمكنني شحن بطاقة المواصلات؟"),
("I need a ticket for the next stop.","أحتاج تذكرة للمحطة التالية."),
("The train is running about ten minutes late.","يتأخر القطار نحو عشر دقائق."),
("Please let me know when we arrive.","من فضلك أخبرني عندما نصل.")]),
("Renting a Room","Ask about accommodation","🏠",[
("Is the room available from next Monday?","هل الغرفة متاحة ابتداءً من الاثنين القادم؟"),
("Are utilities included in the rent?","هل الفواتير مشمولة في الإيجار؟"),
("Could I see the place before deciding?","هل يمكنني معاينة المكان قبل اتخاذ القرار؟"),
("The neighborhood seems quiet and convenient.","يبدو الحي هادئًا ومناسبًا."),
("I would like to read the agreement carefully.","أود قراءة الاتفاق بعناية.")]),
("At the Bank","Handle everyday transactions","🏦",[
("I would like to open a bank account.","أود فتح حساب بنكي."),
("Could you explain this charge?","هل يمكنك توضيح هذه الرسوم؟"),
("I seem to have forgotten my PIN.","يبدو أنني نسيت الرقم السري."),
("How long will the transfer take?","كم سيستغرق التحويل؟"),
("Could I have a printed receipt?","هل يمكنني الحصول على إيصال مطبوع؟")]),
("Meeting Neighbors","Build friendly relationships","🌳",[
("We have just moved in next door.","لقد انتقلنا للتو إلى المنزل المجاور."),
("Please let us know if we are too noisy.","أخبرنا من فضلك إذا كنا نُحدث ضوضاء."),
("Would you like to join us for coffee?","هل تود الانضمام إلينا لتناول القهوة؟"),
("Do you know a good place to buy groceries?","هل تعرف مكانًا جيدًا لشراء البقالة؟"),
("It is nice to finally meet everyone.","يسعدني أخيرًا التعرف إلى الجميع.")]),
("Unexpected Delays","Explain a change of plans","⏳",[
("I am stuck in traffic and may be late.","أنا عالق في الزحام وقد أتأخر."),
("Would it be possible to reschedule?","هل يمكن إعادة تحديد الموعد؟"),
("I will keep you updated.","سأبقيك على اطلاع."),
("Something unexpected has come up.","حدث أمر غير متوقع."),
("Sorry for the inconvenience this has caused.","أعتذر عن الإزعاج الذي سببه هذا.")]),
("City Challenge","Combine everyday communication skills","🎯",[
("Could you recommend somewhere affordable to eat?","هل يمكنك ترشيح مكان مناسب السعر لتناول الطعام؟"),
("I am looking for a quieter route.","أبحث عن طريق أكثر هدوءًا."),
("Let me make sure I have understood correctly.","دعني أتأكد أنني فهمت بشكل صحيح."),
("If I miss this bus, what are my options?","إذا فاتتني هذه الحافلة، فما الخيارات المتاحة؟"),
("Thanks for being so helpful.","شكرًا لكونك متعاونًا جدًا.")]),
]),
("Mystery Files","Follow clues and make careful inferences","🕵️","purple",[
("The Missing Key","Describe clues and possibilities","🔑",[
("The key was on the desk a moment ago.","كان المفتاح على المكتب منذ لحظة."),
("Someone may have moved it.","ربما نقله أحدهم."),
("There are muddy footprints by the window.","توجد آثار أقدام موحلة قرب النافذة."),
("That does not necessarily mean someone broke in.","هذا لا يعني بالضرورة أن أحدًا اقتحم المكان."),
("Let us check the hallway before guessing.","لنتفقد الممر قبل التخمين.")]),
("A Strange Message","Interpret an unclear message","📩",[
("The message was sent just before midnight.","أُرسلت الرسالة قبل منتصف الليل بقليل."),
("It could be a warning, but we cannot be sure.","قد تكون تحذيرًا، لكننا لا نستطيع التأكد."),
("The wording is deliberately vague.","الصياغة غامضة عمدًا."),
("What evidence supports that theory?","ما الدليل الذي يدعم تلك النظرية؟"),
("We should consider another explanation.","ينبغي أن ندرس تفسيرًا آخر.")]),
("The Empty Office","Reconstruct a sequence","🏢",[
("The lights were still on when we arrived.","كانت الأنوار لا تزال مضاءة عندما وصلنا."),
("The computer had been shut down.","كان الكمبيوتر قد أُغلق."),
("Nobody remembers seeing her leave.","لا يتذكر أحد أنه رآها تغادر."),
("She might have left through the side entrance.","ربما غادرت عبر المدخل الجانبي."),
("We need to separate facts from assumptions.","نحتاج إلى فصل الحقائق عن الافتراضات.")]),
("Conflicting Stories","Compare two accounts","🗣️",[
("His account differs from the witness's version.","تختلف روايته عن رواية الشاهد."),
("She said she arrived after the alarm.","قالت إنها وصلت بعد الإنذار."),
("Both accounts cannot be completely accurate.","لا يمكن أن تكون الروايتان دقيقتين تمامًا."),
("Could either person have misunderstood the time?","هل يمكن أن يكون أحدهما قد أساء فهم الوقت؟"),
("Let's verify the timeline independently.","لنتحقق من التسلسل الزمني بشكل مستقل.")]),
("The Unopened Letter","Infer emotion and intent","✉️",[
("The envelope had never been opened.","لم يُفتح الظرف قط."),
("It had been addressed in unfamiliar handwriting.","كُتب العنوان بخط غير مألوف."),
("Perhaps the recipient was afraid of its contents.","ربما خاف المستلم مما بداخله."),
("That is a possibility rather than a proven fact.","هذا احتمال وليس حقيقة مثبتة."),
("The date may help us understand the context.","قد يساعدنا التاريخ على فهم السياق.")]),
("A Room with No Exit","Explain logical constraints","🚪",[
("The only door was locked from the inside.","كان الباب الوحيد مغلقًا من الداخل."),
("The window was too narrow for an adult.","كانت النافذة أضيق من أن يمر منها شخص بالغ."),
("We may be missing an important detail.","ربما أغفلنا تفصيلًا مهمًا."),
("An unusual explanation still needs evidence.","حتى التفسير غير المعتاد يحتاج إلى دليل."),
("Let's test each possibility one by one.","لنختبر كل احتمال على حدة.")]),
("The False Lead","Revise an early assumption","🧩",[
("At first, the clue seemed conclusive.","بدا الدليل حاسمًا في البداية."),
("New evidence has changed our understanding.","غيّر دليل جديد فهمنا."),
("Our original theory no longer fits the facts.","لم تعد نظريتنا الأولى تتوافق مع الحقائق."),
("We should be willing to revise our view.","ينبغي أن نكون مستعدين لمراجعة رأينا."),
("A convincing story is not always a true one.","القصة المقنعة ليست صحيحة دائمًا.")]),
("Interview the Witness","Ask precise follow-up questions","🎙️",[
("What exactly did you notice first?","ما الذي لاحظته تحديدًا أولًا؟"),
("How far away were you standing?","كم كانت المسافة التي تقف عندها؟"),
("Could you see the person's face clearly?","هل استطعت رؤية وجه الشخص بوضوح؟"),
("Are you certain about the time?","هل أنت متأكد من الوقت؟"),
("Is there anything else you remember?","هل تتذكر أي شيء آخر؟")]),
("Case Closed?","Present a cautious conclusion","📁",[
("The evidence points toward one likely explanation.","تشير الأدلة إلى تفسير مرجح."),
("However, one important question remains unanswered.","ومع ذلك، لا يزال سؤال مهم بلا إجابة."),
("We cannot rule out the alternative yet.","لا يمكننا استبعاد الاحتمال الآخر بعد."),
("The conclusion should reflect our uncertainty.","ينبغي أن يعكس الاستنتاج درجة عدم يقيننا."),
("For now, the case remains open.","في الوقت الحالي، تظل القضية مفتوحة.")]),
]),
("Sound Lab","Improve clarity, rhythm, and listening confidence","🎧","green",[
("Word Stress","Make important syllables clearer","🔊",[
("I need a comfortable place to work.","أحتاج إلى مكان مريح للعمل."),
("Could you explain the main point again?","هل يمكنك شرح النقطة الأساسية مجددًا؟"),
("I completely understand your concern.","أتفهم مخاوفك تمامًا."),
("The information was incredibly useful.","كانت المعلومات مفيدة للغاية."),
("Let's focus on the most important detail.","لنركز على أهم تفصيل.")]),
("Connected Speech","Speak in natural groups","〰️",[
("Would you like to come along with us?","هل تود أن تأتي معنا؟"),
("I should have told you earlier.","كان ينبغي أن أخبرك في وقت أبكر."),
("What are you planning to do tomorrow?","ماذا تخطط أن تفعل غدًا؟"),
("We could have handled it differently.","كان بإمكاننا التعامل مع الأمر بطريقة مختلفة."),
("I am going to give it another try.","سأحاول مرة أخرى.")]),
("Similar Sounds","Listen carefully to sound contrasts","👂",[
("Please leave the sheet on the desk.","من فضلك اترك الورقة على المكتب."),
("The ship arrived before sunset.","وصلت السفينة قبل غروب الشمس."),
("We need three clean glasses.","نحتاج إلى ثلاثة أكواب نظيفة."),
("Those clothes are still wet.","تلك الملابس لا تزال مبللة."),
("The price is slightly higher this year.","السعر أعلى قليلًا هذا العام.")]),
("Sentence Rhythm","Use pauses to support meaning","🥁",[
("Although it was raining, we continued walking.","رغم هطول المطر، واصلنا المشي."),
("If you need any help, just let me know.","إذا احتجت إلى مساعدة، فأخبرني."),
("The report, which I sent yesterday, is attached.","التقرير الذي أرسلته أمس مرفق."),
("Before making a decision, consider the alternatives.","قبل اتخاذ قرار، فكّر في البدائل."),
("What matters most is how we respond.","الأهم هو كيفية استجابتنا.")]),
("Clear Endings","Make final sounds audible","🔚",[
("She works with international clients.","هي تعمل مع عملاء دوليين."),
("He asked several difficult questions.","طرح عدة أسئلة صعبة."),
("We finished the project last week.","أنهينا المشروع الأسبوع الماضي."),
("They have already booked their seats.","لقد حجزوا مقاعدهم بالفعل."),
("Please send the documents before Friday.","أرسل المستندات قبل الجمعة من فضلك.")]),
("Speaking in Chunks","Avoid word-by-word delivery","🧱",[
("To be honest, I had a different impression.","بصراحة، كان لدي انطباع مختلف."),
("As far as I can tell, everything is ready.","على حد علمي، كل شيء جاهز."),
("The good news is that we have more time.","الخبر الجيد هو أن لدينا مزيدًا من الوقت."),
("From my point of view, it is worth trying.","من وجهة نظري، الأمر يستحق المحاولة."),
("What I find interesting is the final result.","ما أجده مثيرًا للاهتمام هو النتيجة النهائية.")]),
("Listen for Meaning","Catch key information","📝",[
("The meeting has been moved to Thursday afternoon.","نُقل الاجتماع إلى عصر الخميس."),
("Please bring the signed form and your identification.","أحضر النموذج الموقع وبطاقة هويتك."),
("The cheaper option takes slightly longer.","الخيار الأرخص يستغرق وقتًا أطول قليلًا."),
("We will contact you once the results are ready.","سنتواصل معك عندما تصبح النتائج جاهزة."),
("The speaker disagreed with the final recommendation.","اختلف المتحدث مع التوصية النهائية.")]),
("Repair a Misunderstanding","Ask someone to clarify","🔁",[
("Sorry, I missed the last part of that.","عذرًا، لم أسمع الجزء الأخير."),
("Do you mean the meeting is postponed?","هل تقصد أن الاجتماع قد تأجل؟"),
("Let me rephrase that more clearly.","دعني أعيد صياغة ذلك بوضوح أكبر."),
("I may have misunderstood what you meant.","ربما أسأت فهم ما قصدته."),
("Could you give me a quick example?","هل يمكنك إعطائي مثالًا سريعًا؟")]),
("Sound Check","Combine pronunciation strategies","🎚️",[
("Clear communication is a skill we can develop.","التواصل الواضح مهارة يمكننا تطويرها."),
("I try to speak naturally rather than quickly.","أحاول التحدث بطبيعية بدلًا من السرعة."),
("Pausing briefly can make a point more powerful.","قد يجعل التوقف القصير الفكرة أقوى."),
("I pay attention to stress and sentence rhythm.","أنتبه إلى النبر وإيقاع الجملة."),
("Confidence grows when practice becomes a habit.","تزداد الثقة عندما تصبح الممارسة عادة.")]),
]),
("Choice & Consequence","Navigate conversations with tact","🎭","orange",[
("A Difficult Request","Set boundaries politely","🧭",[
("I would like to help, but I have a deadline.","أود المساعدة، لكن لدي موعد تسليم."),
("Could we agree on a more realistic timeline?","هل يمكننا الاتفاق على جدول زمني أكثر واقعية؟"),
("I am not able to commit to that right now.","لا أستطيع الالتزام بذلك الآن."),
("What if we divide the task between us?","ماذا لو قسمنا المهمة بيننا؟"),
("I appreciate you asking me.","أقدّر أنك طلبت مني ذلك.")]),
("Giving Feedback","Be honest and constructive","🪴",[
("The main idea is strong, but the opening is unclear.","الفكرة الأساسية قوية، لكن المقدمة غير واضحة."),
("One improvement would be to add a concrete example.","من التحسينات الممكنة إضافة مثال ملموس."),
("I can see how much effort you put into this.","أرى مقدار الجهد الذي بذلته في هذا."),
("Would you be open to a small suggestion?","هل تتقبل اقتراحًا صغيرًا؟"),
("Let's focus on what can be improved next.","لنركز على ما يمكن تحسينه لاحقًا.")]),
("Apologizing Well","Take responsibility","🤝",[
("I should have informed you sooner.","كان ينبغي أن أبلغك في وقت أبكر."),
("I understand why that caused frustration.","أتفهم سبب الإحباط الذي نتج عن ذلك."),
("I take responsibility for my part.","أتحمل مسؤولية الجزء الخاص بي."),
("Here is what I will do to put it right.","إليك ما سأفعله لتصحيح الأمر."),
("It will not happen again without warning.","لن يتكرر الأمر دون تنبيه مسبق.")]),
("Negotiating Plans","Find a workable compromise","🗓️",[
("Friday works for me, if we start early.","الجمعة مناسبة لي إذا بدأنا مبكرًا."),
("Would Saturday be a reasonable compromise?","هل سيكون السبت حلًا وسطًا مناسبًا؟"),
("I can be flexible about the location.","يمكنني المرونة بشأن المكان."),
("Let's identify what matters most to each of us.","لنحدد ما يهم كلًا منا أكثر."),
("That sounds fair to both sides.","يبدو ذلك عادلًا للطرفين.")]),
("An Awkward Silence","Keep a conversation moving","☕",[
("How did you first become interested in that?","كيف بدأ اهتمامك بذلك؟"),
("What has been the highlight of your week?","ما أفضل ما حدث لك هذا الأسبوع؟"),
("I have been meaning to ask you about your project.","كنت أريد سؤالك عن مشروعك."),
("That reminds me of something similar.","هذا يذكرني بشيء مشابه."),
("I'd love to hear more about your experience.","أود سماع المزيد عن تجربتك.")]),
("Disagreeing Respectfully","Challenge ideas, not people","⚖️",[
("I see your point, although I interpret the evidence differently.","أفهم وجهة نظرك، لكنني أفسر الأدلة بشكل مختلف."),
("Could there be another way to look at this?","هل يمكن النظر إلى الأمر بطريقة أخرى؟"),
("I agree with the goal, but not the proposed method.","أوافق على الهدف، لكن ليس على الطريقة المقترحة."),
("That is a fair concern to raise.","هذا تخوف وجيه يستحق الطرح."),
("Perhaps we can find common ground.","ربما نستطيع إيجاد أرضية مشتركة.")]),
("The Last-Minute Change","Respond calmly to change","🔄",[
("I have just heard that the venue has changed.","علمت للتو أن المكان قد تغير."),
("Let's work out what this affects first.","لنحدد أولًا ما الذي سيتأثر بذلك."),
("I can adjust one part of the plan.","يمكنني تعديل جزء من الخطة."),
("We should tell everyone as soon as possible.","ينبغي إخبار الجميع في أقرب وقت."),
("Despite the change, we can still make it work.","رغم التغيير، لا يزال بإمكاننا إنجاح الأمر.")]),
("Reading the Room","Notice indirect signals","👀",[
("She seems hesitant to give a direct answer.","تبدو مترددة في إعطاء إجابة مباشرة."),
("Perhaps now is not the best time to ask.","ربما ليس هذا أفضل وقت للسؤال."),
("His tone sounded warmer than his words.","بدت نبرته أود من كلماته."),
("Let's check rather than assume what they feel.","لنتحقق بدلًا من افتراض مشاعرهم."),
("A little tact can prevent a bigger conflict.","يمكن لقليل من اللباقة منع خلاف أكبر.")]),
("Branching Conversation","Choose a response that moves things forward","🌿",[
("I understand the concern; what outcome would help?","أتفهم القلق؛ ما النتيجة التي قد تساعد؟"),
("Would you prefer a quick solution or a lasting one?","هل تفضل حلًا سريعًا أم دائمًا؟"),
("Let's compare the trade-offs before deciding.","لنقارن المزايا والتنازلات قبل القرار."),
("I can accept that if we clarify the next steps.","يمكنني قبول ذلك إذا وضحنا الخطوات التالية."),
("We have a plan, and we know who will do what.","لدينا خطة ونعرف مسؤولية كل شخص.")]),
]),
("Story Forge","Tell richer stories and express nuance","📚","purple",[
("Set the Scene","Establish place and mood","🌆",[
("By the time we arrived, the streets were almost empty.","بحلول وصولنا، كانت الشوارع شبه خالية."),
("A cold wind was blowing through the narrow alley.","كانت رياح باردة تهب عبر الزقاق الضيق."),
("In the distance, a single light was flickering.","في البعيد، كان ضوء واحد يومض."),
("Everything seemed ordinary until the phone rang.","بدا كل شيء عاديًا حتى رن الهاتف."),
("I had no idea that the evening would change everything.","لم أكن أعلم أن المساء سيغير كل شيء.")]),
("Build Suspense","Control what the reader knows","🕯️",[
("Something about his explanation did not add up.","كان هناك شيء غير منطقي في تفسيره."),
("Just as I was about to leave, I noticed the envelope.","بينما كنت على وشك المغادرة، لاحظت الظرف."),
("She paused, as though choosing her words carefully.","توقفت وكأنها تختار كلماتها بعناية."),
("The silence that followed felt unusually long.","بدا الصمت الذي تلا ذلك طويلًا على نحو غير معتاد."),
("Then I realized that the door had been open all along.","ثم أدركت أن الباب كان مفتوحًا طوال الوقت.")]),
("Describe a Turning Point","Show a change in direction","↗️",[
("That was the moment I began to question my decision.","كانت تلك اللحظة التي بدأت فيها التشكيك في قراري."),
("What seemed like a setback became an opportunity.","ما بدا انتكاسة تحول إلى فرصة."),
("I had to choose between comfort and honesty.","كان عليّ الاختيار بين الراحة والصدق."),
("Looking back, I can see why it mattered.","عند النظر إلى الماضي، أرى لماذا كان ذلك مهمًا."),
("From then on, nothing felt quite the same.","منذ ذلك الحين، لم يعد شيء كما كان تمامًا.")]),
("Tell It Another Way","Paraphrase without losing meaning","🔀",[
("In other words, we need more time to prepare.","بعبارة أخرى، نحتاج إلى مزيد من الوقت للاستعداد."),
("What I am trying to say is that the plan needs work.","ما أحاول قوله هو أن الخطة تحتاج إلى تحسين."),
("To put it differently, the risk is still too high.","بصياغة أخرى، لا تزال المخاطرة مرتفعة جدًا."),
("The point is not that we failed, but that we learned.","ليس المقصود أننا فشلنا، بل أننا تعلمنا."),
("In short, the evidence does not support that claim.","باختصار، لا تدعم الأدلة ذلك الادعاء.")]),
("Character and Motive","Explain why someone acts","🎭",[
("He acted as though he had nothing to lose.","تصرف كما لو أنه لا يملك ما يخسره."),
("She was reluctant to admit how worried she was.","ترددت في الاعتراف بمدى قلقها."),
("His generosity seemed genuine rather than strategic.","بدت كرماته صادقة لا محسوبة."),
("I suspect she wanted to protect someone.","أظن أنها أرادت حماية شخص ما."),
("Their actions revealed more than their promises.","كشفت أفعالهم أكثر مما كشفت وعودهم.")]),
("Use Precise Details","Replace vague language","🔍",[
("The room smelled faintly of rain and old paper.","كانت رائحة المطر والورق القديم تفوح من الغرفة."),
("He answered after a brief but uncomfortable pause.","أجاب بعد توقف قصير لكنه محرج."),
("The glass trembled as the train passed.","اهتز الزجاج بينما مر القطار."),
("Her voice grew quieter with every sentence.","أصبح صوتها أخفض مع كل جملة."),
("A small detail made the entire scene believable.","جعل تفصيل صغير المشهد كله قابلًا للتصديق.")]),
("Cause and Effect","Connect events logically","🔗",[
("Because the evidence was incomplete, we delayed the decision.","لأن الأدلة لم تكن مكتملة، أجلنا القرار."),
("The delay meant that we had to change our approach.","يعني التأخير أننا اضطررنا لتغيير نهجنا."),
("Had we checked earlier, we might have avoided the problem.","لو تحققنا مبكرًا، لربما تجنبنا المشكلة."),
("As a result, the team became more cautious.","ونتيجة لذلك، أصبح الفريق أكثر حذرًا."),
("This experience taught us to plan for uncertainty.","علمتنا هذه التجربة التخطيط لعدم اليقين.")]),
("Narrative Perspective","Shift the point of view","👁️",[
("From her perspective, the decision seemed inevitable.","من وجهة نظرها، بدا القرار حتميًا."),
("I only learned the truth years later.","لم أعرف الحقيقة إلا بعد سنوات."),
("At the time, none of us understood the consequences.","في ذلك الوقت، لم يفهم أي منا العواقب."),
("What I remember most clearly is the sound of footsteps.","أكثر ما أتذكره بوضوح هو صوت الخطوات."),
("If he had told the story, he might have described it differently.","لو روى هو القصة، لربما وصفها بشكل مختلف.")]),
("Final Story","Bring a story to a meaningful close","🏁",[
("In the end, the answer was simpler than we expected.","في النهاية، كانت الإجابة أبسط مما توقعنا."),
("We never discovered who had left the note.","لم نكتشف أبدًا من ترك الملاحظة."),
("Some questions remained, but the fear had passed.","بقيت بعض الأسئلة، لكن الخوف زال."),
("I realized that the journey had changed me.","أدركت أن الرحلة قد غيرتني."),
("And that is why I still remember that night.","ولهذا ما زلت أتذكر تلك الليلة.")]),
]),
("Debate Arena","Build arguments and evaluate evidence","⚔️","orange",[
("Make a Clear Claim","State and qualify an argument","📣",[
("My main argument is that access matters more than convenience.","حجتي الأساسية أن إمكانية الوصول أهم من الراحة."),
("This claim depends on how we define success.","يعتمد هذا الادعاء على كيفية تعريف النجاح."),
("The strongest evidence in favor is the long-term result.","أقوى دليل مؤيد هو النتيجة طويلة المدى."),
("We should distinguish correlation from causation.","ينبغي التمييز بين الارتباط والسببية."),
("I would qualify that conclusion in one important respect.","سأقيّد ذلك الاستنتاج من ناحية مهمة.")]),
("Support with Evidence","Explain why a claim is credible","📊",[
("The data supports the trend, though not every case.","تدعم البيانات الاتجاه، وإن لم تدعم كل حالة."),
("A concrete example helps illustrate the mechanism.","يساعد مثال ملموس على توضيح الآلية."),
("We need to know how the sample was selected.","نحتاج إلى معرفة كيفية اختيار العينة."),
("That source is useful, but it has clear limitations.","هذا المصدر مفيد، لكنه محدود بوضوح."),
("The conclusion should not go beyond the evidence.","ينبغي ألا يتجاوز الاستنتاج الأدلة المتاحة.")]),
("Counterarguments","Address the strongest objection","🥊",[
("A reasonable objection is that the costs may be too high.","اعتراض معقول هو أن التكاليف قد تكون مرتفعة جدًا."),
("That concern is valid, but it is not decisive.","هذا التخوف وجيه، لكنه ليس حاسمًا."),
("The opposing view overlooks one practical constraint.","يغفل الرأي المعارض قيدًا عمليًا."),
("Even so, we should acknowledge the trade-off.","ومع ذلك، ينبغي الاعتراف بالمقايضة."),
("A stronger version of the objection would be this.","يمكن صياغة الاعتراض بصورة أقوى هكذا.")]),
("Avoid Logical Traps","Spot weak reasoning","🧠",[
("One example does not establish a general rule.","لا يثبت مثال واحد قاعدة عامة."),
("The argument assumes what it needs to prove.","تفترض الحجة ما تحتاج إلى إثباته."),
("Those two events may share a cause.","قد يكون للحدثين سبب مشترك."),
("The absence of evidence is not always evidence of absence.","غياب الدليل ليس دائمًا دليلًا على الغياب."),
("We should compare the alternatives fairly.","ينبغي مقارنة البدائل بإنصاف.")]),
("Weigh the Evidence","Compare competing explanations","⚖️",[
("This explanation accounts for more of the available facts.","يفسر هذا التفسير عددًا أكبر من الحقائق المتاحة."),
("The alternative is simpler, but less comprehensive.","البديل أبسط لكنه أقل شمولًا."),
("We should consider how likely each explanation is.","ينبغي النظر في مدى احتمال كل تفسير."),
("A single exception may weaken, but not destroy, the pattern.","قد يضعف استثناء واحد النمط دون أن يلغيه."),
("For now, the balance of evidence favors the first view.","حتى الآن، ترجح كفة الأدلة الرأي الأول.")]),
("Persuade an Audience","Adapt language to your listeners","🎤",[
("The practical benefit is what matters most here.","الفائدة العملية هي الأهم هنا."),
("Let me illustrate that with a familiar example.","دعني أوضح ذلك بمثال مألوف."),
("You do not have to agree with every detail.","ليس عليك الموافقة على كل تفصيل."),
("Consider what would happen if we did nothing.","فكر فيما قد يحدث إذا لم نفعل شيئًا."),
("The choice ultimately depends on our priorities.","يعتمد الاختيار في النهاية على أولوياتنا.")]),
("Ethical Dilemmas","Balance competing values","🧭",[
("The decision protects privacy but reduces transparency.","يحمي القرار الخصوصية لكنه يقلل الشفافية."),
("There is no option without a meaningful cost.","لا يوجد خيار بلا تكلفة حقيقية."),
("We need to ask who bears most of the risk.","نحتاج إلى السؤال عمن يتحمل معظم المخاطر."),
("A fair solution should explain its guiding principles.","ينبغي للحل العادل توضيح المبادئ التي توجهه."),
("The right answer may depend on the circumstances.","قد تعتمد الإجابة الصحيحة على الظروف.")]),
("Debate Under Pressure","Respond without losing precision","⏱️",[
("Let me address the central point directly.","دعني أتناول النقطة الأساسية مباشرة."),
("That conclusion does not follow from the premise.","لا ينتج ذلك الاستنتاج عن المقدمة."),
("I agree with the observation, not the interpretation.","أوافق على الملاحظة لا على التفسير."),
("We are using the same term in different ways.","نستخدم المصطلح نفسه بمعنيين مختلفين."),
("I will revise my position if stronger evidence emerges.","سأراجع موقفي إذا ظهرت أدلة أقوى.")]),
("Closing Statement","Summarize a balanced position","🏆",[
("The evidence is mixed, but a cautious conclusion is possible.","الأدلة متباينة، لكن يمكن الوصول إلى استنتاج حذر."),
("The benefits are substantial if the safeguards work.","الفوائد كبيرة إذا نجحت الضمانات."),
("The strongest objection remains unresolved.","لا يزال أقوى اعتراض بلا حل."),
("On balance, I support the proposal with conditions.","في المحصلة، أؤيد المقترح بشروط."),
("That is the position I can defend with the evidence available.","هذا هو الموقف الذي أستطيع الدفاع عنه بالأدلة المتاحة.")]),
]),
("Language Mastery","Express subtle meaning with precision","🧠","blue",[
("Implied Meaning","Read between the lines","🕵️",[
("That is certainly one way to approach the problem.","هذا بالتأكيد أحد أساليب التعامل مع المشكلة."),
("I would not call the timing ideal.","لن أصف التوقيت بأنه مثالي."),
("Some aspects of the proposal deserve further thought.","تستحق بعض جوانب المقترح مزيدًا من التفكير."),
("Her response was polite, though noticeably brief.","كان ردها مهذبًا لكنه مقتضب بشكل ملحوظ."),
("The wording leaves room for more than one interpretation.","تترك الصياغة مجالًا لأكثر من تفسير.")]),
("Register and Tone","Choose language for context","🎩",[
("Could you possibly clarify the intended outcome?","هل يمكنك توضيح النتيجة المقصودة؟"),
("I am writing to enquire about the advertised position.","أكتب للاستفسار عن الوظيفة المعلن عنها."),
("That approach strikes me as unnecessarily confrontational.","يبدو لي هذا النهج تصادميًا دون داعٍ."),
("We would be grateful for your prompt response.","سنكون ممتنين لردكم السريع."),
("Let's keep the discussion constructive and focused.","لنجعل النقاش بنّاءً ومركزًا.")]),
("Hedging Carefully","Show the right degree of certainty","🌫️",[
("The findings appear to suggest a modest improvement.","يبدو أن النتائج تشير إلى تحسن محدود."),
("It is plausible, although the evidence is inconclusive.","هذا احتمال معقول، رغم أن الأدلة غير حاسمة."),
("We cannot entirely discount that possibility.","لا يمكننا استبعاد هذا الاحتمال تمامًا."),
("The pattern may be partly explained by external factors.","قد تفسر العوامل الخارجية هذا النمط جزئيًا."),
("I would be reluctant to draw a firm conclusion yet.","سأتردد في استخلاص نتيجة قاطعة الآن.")]),
("Nuanced Vocabulary","Choose the most accurate word","🧩",[
("The distinction is subtle but consequential.","التمييز دقيق لكنه مؤثر."),
("Her criticism was measured rather than dismissive.","كان نقدها متزنًا لا رافضًا."),
("The proposal is feasible, provided funding is secured.","المقترح قابل للتنفيذ بشرط تأمين التمويل."),
("His account was consistent with the available records.","توافقت روايته مع السجلات المتاحة."),
("The outcome was unexpected, though not implausible.","كانت النتيجة غير متوقعة لكنها ليست مستبعدة.")]),
("Complex Sentence Control","Express relationships clearly","🧵",[
("While the evidence is limited, the trend is worth examining.","رغم محدودية الأدلة، يستحق الاتجاه الدراسة."),
("What matters is not whether the plan is ambitious, but whether it is workable.","المهم ليس طموح الخطة، بل قابليتها للتنفيذ."),
("The report, having considered several alternatives, recommends a phased approach.","يوصي التقرير، بعد دراسة عدة بدائل، بنهج مرحلي."),
("Were the assumptions to change, the result might differ.","لو تغيرت الافتراضات، فقد تختلف النتيجة."),
("The more carefully we define the problem, the easier it becomes to solve.","كلما حددنا المشكلة بعناية، أصبح حلها أسهل.")]),
("Summarize Complex Ideas","Keep the central meaning","📄",[
("In essence, the proposal trades speed for greater reliability.","في جوهره، يستبدل المقترح السرعة بموثوقية أكبر."),
("The report identifies a gap between policy and practice.","يحدد التقرير فجوة بين السياسة والتطبيق."),
("The key limitation is the lack of long-term evidence.","القيد الأساسي هو غياب الأدلة طويلة الأجل."),
("Taken together, the results support a cautious interpretation.","تدعم النتائج مجتمعة تفسيرًا حذرًا."),
("The details differ, but the underlying principle is shared.","تختلف التفاصيل، لكن المبدأ الأساسي مشترك.")]),
("Precision in Disagreement","Qualify criticism accurately","🎯",[
("I question the assumption rather than the overall objective.","أشكك في الافتراض لا في الهدف العام."),
("The evidence is insufficient to justify that stronger claim.","الأدلة غير كافية لتبرير هذا الادعاء الأقوى."),
("That is partly true, but it omits an important condition.","هذا صحيح جزئيًا، لكنه يغفل شرطًا مهمًا."),
("I would distinguish the immediate effect from the long-term impact.","سأميز بين الأثر الفوري والتأثير طويل الأجل."),
("Our disagreement may concern definitions more than facts.","قد يتعلق خلافنا بالتعريفات أكثر من الحقائق.")]),
("Idiomatic Fluency","Use natural expressions appropriately","💬",[
("We need to get to the bottom of this.","نحتاج إلى كشف حقيقة الأمر."),
("That plan sounds good on paper.","تبدو تلك الخطة جيدة نظريًا."),
("I do not want to jump to conclusions.","لا أريد التسرع في الاستنتاج."),
("Let's keep the bigger picture in mind.","لنبقِ الصورة الأكبر في أذهاننا."),
("The issue has been blown out of proportion.","تم تضخيم المشكلة أكثر من اللازم.")]),
("Mastery Check","Integrate accuracy, tone, and nuance","🏅",[
("The available evidence lends some support to that interpretation.","تقدم الأدلة المتاحة بعض الدعم لذلك التفسير."),
("I would frame the conclusion more cautiously.","سأصوغ الاستنتاج بحذر أكبر."),
("The distinction is relevant, but not sufficient on its own.","هذا التمييز مهم لكنه غير كافٍ بمفرده."),
("A more balanced assessment would consider both outcomes.","سيأخذ التقييم الأكثر توازنًا النتيجتين في الاعتبار."),
("The conclusion should remain open to revision.","ينبغي أن يظل الاستنتاج قابلًا للمراجعة.")]),
]),
("The C1 Expedition","Combine advanced skills in a final challenge","🏔️","green",[
("Research Briefing","Explain findings with appropriate caution","🔬",[
("The preliminary findings warrant further investigation.","تستدعي النتائج الأولية مزيدًا من البحث."),
("The sample is too limited to support broad generalizations.","العينة محدودة أكثر من اللازم لدعم تعميمات واسعة."),
("Several plausible explanations remain under consideration.","لا تزال عدة تفسيرات معقولة قيد الدراسة."),
("The report distinguishes observed outcomes from projected ones.","يميز التقرير بين النتائج المرصودة والمتوقعة."),
("Our recommendations reflect both the evidence and its limitations.","تعكس توصياتنا الأدلة وحدودها معًا.")]),
("Lead a Meeting","Guide a group toward a decision","🧑‍💼",[
("Before we move on, are there any outstanding concerns?","قبل أن ننتقل، هل توجد مخاوف لم تُحسم؟"),
("Let's separate the urgent items from the important ones.","لنميز الأمور العاجلة عن الأمور المهمة."),
("Could we hear from someone who has not spoken yet?","هل يمكننا الاستماع إلى شخص لم يتحدث بعد؟"),
("I suggest we record the decision and its rationale.","أقترح تسجيل القرار وأسبابه."),
("We have enough information to agree on the next step.","لدينا معلومات كافية للاتفاق على الخطوة التالية.")]),
("Handle a Crisis","Communicate clearly under pressure","🚨",[
("Our immediate priority is to establish what happened.","أولويتنا الفورية هي تحديد ما حدث."),
("Please rely on confirmed information rather than speculation.","اعتمدوا على المعلومات المؤكدة بدلًا من التكهنات."),
("We will issue an update as soon as we can verify the facts.","سنصدر تحديثًا فور التحقق من الحقائق."),
("The situation is serious, but the response is coordinated.","الوضع خطير، لكن الاستجابة منسقة."),
("We need a clear record of every action taken.","نحتاج إلى سجل واضح لكل إجراء اتُخذ.")]),
("Mediate a Dispute","Find common ground between positions","🕊️",[
("Each side has raised a concern that deserves consideration.","طرح كل طرف تخوفًا يستحق النظر."),
("Could you identify the outcome you both want?","هل يمكنكما تحديد النتيجة التي تريدانها معًا؟"),
("The disagreement seems to center on the process.","يبدو أن الخلاف يتمحور حول الإجراءات."),
("A workable compromise may preserve the core priorities.","قد يحافظ حل وسط عملي على الأولويات الأساسية."),
("Let's confirm what each party is willing to accept.","لنتأكد مما يقبل به كل طرف.")]),
("Present a Proposal","Make a structured case","📈",[
("The proposal addresses the problem in three stages.","يعالج المقترح المشكلة على ثلاث مراحل."),
("The expected benefit outweighs the initial implementation cost.","تفوق الفائدة المتوقعة تكلفة التنفيذ الأولية."),
("We have included safeguards against the main risks.","أدرجنا ضمانات ضد المخاطر الرئيسية."),
("Success will depend on transparent evaluation.","سيعتمد النجاح على التقييم الشفاف."),
("I welcome scrutiny of the assumptions behind this plan.","أرحب بفحص الافتراضات التي تقوم عليها هذه الخطة.")]),
("Respond to Criticism","Separate useful feedback from tone","🛡️",[
("That criticism highlights a weakness we should address.","يسلط هذا النقد الضوء على نقطة ضعف ينبغي معالجتها."),
("I agree with the concern, though not every implication.","أوافق على التخوف، وإن لم أوافق على كل ما يترتب عليه."),
("Could you point to the specific evidence behind that claim?","هل يمكنك الإشارة إلى الدليل المحدد وراء هذا الادعاء؟"),
("We should revise the plan where the criticism is justified.","ينبغي تعديل الخطة حيث يكون النقد مبررًا."),
("The objective is improvement, not defending every detail.","الهدف هو التحسين، لا الدفاع عن كل تفصيل.")]),
("Synthesize Perspectives","Combine insights without flattening differences","🧬",[
("Both accounts capture part of a more complicated picture.","تلتقط الروايتان جزءًا من صورة أكثر تعقيدًا."),
("The common ground is narrower, but still meaningful.","نقاط الاتفاق أضيق لكنها لا تزال مهمة."),
("These findings complement one another rather than conflict.","تكمل هذه النتائج بعضها بعضًا بدلًا من التعارض."),
("A synthesis should preserve the strongest point from each view.","ينبغي أن يحافظ التركيب على أقوى نقطة في كل رأي."),
("The remaining tension cannot be resolved by wording alone.","لا يمكن حل التوتر المتبقي بمجرد تغيير الصياغة.")]),
("Reflect and Refine","Evaluate your own communication","🪞",[
("I could have made the central point more explicit.","كان بإمكاني توضيح الفكرة الأساسية بصورة أكبر."),
("My wording may have sounded more certain than I intended.","ربما بدت صياغتي أكثر يقينًا مما قصدت."),
("A better example would have made the distinction clearer.","كان مثال أفضل سيجعل التمييز أوضح."),
("I should check understanding before moving forward.","ينبغي أن أتحقق من الفهم قبل المتابعة."),
("Reflection helps turn experience into deliberate practice.","يساعد التأمل على تحويل الخبرة إلى ممارسة واعية.")]),
("Expedition Finale","Demonstrate integrated advanced communication","🏁",[
("I will present the conclusion, the caveats, and the next steps.","سأعرض الاستنتاج والتحفظات والخطوات التالية."),
("The strongest position is the one that survives careful scrutiny.","أقوى موقف هو الذي يصمد أمام الفحص الدقيق."),
("We should act decisively while remaining open to new evidence.","ينبغي أن نتصرف بحزم مع الانفتاح على أدلة جديدة."),
("Clear communication makes complex decisions more manageable.","يجعل التواصل الواضح القرارات المعقدة أسهل في التعامل."),
("The goal is not flawless speech, but precise and effective meaning.","الهدف ليس الكلام الخالي من العيوب، بل المعنى الدقيق والفعال.")]),
]),
]

def dart(s):
    return "'" + s.replace("\\", "\\\\").replace("'", "\\'") + "'"

def make_lesson(lesson_id, title, subtitle, emoji, color, phrases, unit_index, lesson_index):
    xp = 50 + (unit_index - 5) * 5 + (lesson_index // 3) * 2
    lines = [
        "      Lesson(",
        f"        id: {dart(lesson_id)},",
        f"        title: {dart(title)},",
        f"        subtitle: {dart(subtitle)},",
        f"        emoji: {dart(emoji)},",
        f"        color: ColorSeed.{color},",
        f"        xpReward: {xp},",
        "        exercises: [",
    ]
    for j, (en, ar) in enumerate(phrases):
        # Mix the existing supported types to avoid introducing enum values
        # before the practice screen is upgraded to handle additional task types.
        kind = ["listenRepeat", "speakPrompt", "listenRepeat", "chooseAndSay", "speakPrompt"][j]
        lines += [
            "          Exercise(",
            f"            type: ExerciseType.{kind},",
            "            phrase: Phrase(",
            f"              text: {dart(en)},",
            f"              meaningAr: {dart(ar)},",
            "            ),",
        ]
        if kind == "chooseAndSay":
            wrong = [
                "Could you explain that another way?",
                "I am not entirely sure about that.",
            ]
            choices = [en, wrong[(unit_index + lesson_index) % 2], wrong[(unit_index + lesson_index + 1) % 2]]
            # Correct answer is deliberately not always first; deterministic shuffle.
            if (unit_index + lesson_index) % 2:
                choices = [choices[1], choices[0], choices[2]]
            lines += ["            choices: ["]
            lines += [f"              {dart(c)}," for c in choices]
            lines += ["            ],"]
        lines += ["          ),"]
    lines += ["        ],", "      ),"]
    return "\n".join(lines)

new_units = []
lesson_num = 14
for ui, (unit_title, desc, unit_emoji, color, lesson_rows) in enumerate(units, start=5):
    lesson_blocks = []
    for li, (title, subtitle, emoji, phrases) in enumerate(lesson_rows):
        lesson_blocks.append(make_lesson(f"l{lesson_num}", title, subtitle, emoji, color, phrases, ui, li))
        lesson_num += 1
    new_units.append(
        "  Unit(\n"
        f"    id: 'u{ui}',\n"
        f"    title: {dart(f'Unit {ui} · {unit_title}')},\n"
        f"    description: {dart(desc)},\n"
        "    lessons: [\n" + "\n".join(lesson_blocks) + "\n    ],\n"
        "  ),"
    )

marker = "\n];\n\nLesson? findLesson(String id)"
if marker not in src:
    sys.exit("Could not locate the end of curriculum list. No files changed.")

# Confirm exactly 8 x 9 lessons were authored.
assert lesson_num == 86, f"Expected next lesson ID l86, got l{lesson_num}"

stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
backup_dir = ROOT / "SpeakLocal_Backups" / f"before_expansion_{stamp}"
backup_dir.mkdir(parents=True, exist_ok=False)
shutil.copy2(LESSONS, backup_dir / "lessons.dart")
shutil.copy2(MODEL, backup_dir / "lesson.dart")

expanded = src.replace(marker, "\n" + "\n".join(new_units) + marker, 1)
LESSONS.write_text(expanded, encoding="utf-8")

print("Curriculum expanded.")
print(f"Backup folder: {backup_dir}")
print("Expected curriculum: 12 units, 85 lessons (l1-l85).")
print("Note: this first pass uses existing exercise types for compatibility.")
print("Next: run flutter analyze and tests; the choose-and-say scoring/UI refinement is a separate safe patch.")
