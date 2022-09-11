import 'package:experiences_app/modules/Search/search_cubit/search_cubit.dart';
import 'package:experiences_app/modules/Search/search_cubit/search_states.dart';
import 'package:experiences_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchControlleer = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      myTextFormField(
                        filledNeed: true,
                        fillColor: Colors.grey.shade100,
                        textEditingController: searchControlleer,
                        typeInput: TextInputType.text,
                        label: 'Search',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.search),
                        onSubmit: (value) {
                          SearchCubit.get(context).search(value);
                        },
                      ),
                      const SizedBox(height: 10),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 10),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListProducts(
                              SearchCubit.get(context)
                                  .model
                                  ?.data
                                  ?.data?[index],
                              context,
                              isOldPrice: false,
                            ),
                            separatorBuilder: (context, index) => const Divider(
                              indent: 20,
                              color: Colors.deepOrangeAccent,
                              thickness: 0.2,
                            ),
                            itemCount: SearchCubit.get(context)
                                    .model
                                    ?.data
                                    ?.data
                                    ?.length ??
                                0,
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
