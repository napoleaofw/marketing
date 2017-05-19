@extends('website.layout.index')
@section('edit')
<div id="edit" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row page-content">
            <section id="ads-edit" class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
                <div class="box">
                    <div class="box-body">
                        @include('website.layout.messages')
                        <form method="post">
                            <h2 id="ads-name" class="title">Título do anúncio</h2>
                            <input type="hidden" name="_token" value="{{csrf_token()}}">
                            <input type="text" name="title" value="{{isset($oldInput['title']) ? $oldInput['title'] : (isset($adRecord->ad_title) ? $adRecord->ad_title : '')}}">
                            <section id="ads-category-section">
                                <h2 class="title">Categoria</h2>
                                <label for="category">Categoria principal</label>
                                <select name="category">
                                    <option value="">Selecione</option>
                                    @foreach($categoryRecordList as $categoryRecord)
                                        <option value="{{$categoryRecord->id}}" {{isset($oldInput['category']) ? $categoryRecord->id == $oldInput['category'] : (isset($adCategoryData->main_category_id) && $categoryRecord->id == $adCategoryData->main_category_id) ? 'selected' : ''}}>{{$categoryRecord->name}}</option>
                                    @endforeach
                                </select>
                                <label for="subcategory">Subcategoria</label>
                                <select name="subcategory">
                                    <option value="">Selecione</option>
                                    @foreach($subcategoryRecordList as $subcategoryRecord)
                                        <option value="{{$subcategoryRecord->id}}" {{ isset($oldInput['subcategory']) ? $subcategoryRecord->id == $oldInput['subcategory'] : (isset($adCategoryData->category_id) && $subcategoryRecord->id == $adCategoryData->category_id) ? 'selected' : ''}}>{{$subcategoryRecord->name}}</option>
                                    @endforeach
                                </select>
                            </section>
                            <section id="ads-address-section">
                                <h2 class="title">
                                    Endereço
                                </h2>
                                <label for="address">Endereço</label>
                                <input type="text" name="address" value="{{isset($oldInput['address']) ? $oldInput['address'] : (isset($adRecord->ad_address) ? $adRecord->ad_address : '')}}">
                                <label for="address_number">Número</label>
                                <input type="text" name="address_number" value="{{isset($oldInput['address_number']) ? $oldInput['address_number'] : (isset($adRecord->ad_address_number) ? $adRecord->ad_address_number : '')}}">
                                <label for="address_complement">Complemento</label>
                                <input type="text" name="address_complement" value="{{isset($oldInput['address_complement']) ? $oldInput['address_complement'] : (isset($adRecord->ad_address_complement) ? $adRecord->ad_address_complement : '')}}">
                                <label for="postal_code">CEP</label>
                                <input type="text" name="postal_code" value="{{isset($oldInput['postal_code']) ? $oldInput['postal_code'] : (isset($adRecord->ad_postal_code) ? $adRecord->ad_postal_code : '')}}">
                                <label for="district">Bairro</label>
                                <input type="text" name="district" value="{{isset($oldInput['district']) ? $oldInput['district'] : (isset($adRecord->ad_district) ? $adRecord->ad_district : '')}}">
                                <label for="city">Cidade</label>
                                <select name="city">
                                    <option value="">Selecione</option>
                                    @foreach($cityRecordList as $cityRecord)
                                        <option value="{{$cityRecord->id}}" {{isset($oldInput['city']) ? $cityRecord->id == $oldInput['city'] : (isset($adRecord->city_id) && $cityRecord->id == $adRecord->city_id) ? 'selected' : ''}}>{{$cityRecord->name}}</option>
                                    @endforeach
                                </select>
                                <label for="map_latitude">Latitude</label>
                                <input type="text" name="map_latitude" value="{{isset($oldInput['map_latitude']) ? $oldInput['map_latitude'] : (isset($adRecord->ad_map_latitude) ? $adRecord->ad_map_latitude : '')}}">
                                <label for="map_longitude">Longitude</label>
                                <input type="text" name="map_longitude" value="{{isset($oldInput['map_longitude']) ? $oldInput['map_longitude'] : (isset($adRecord->ad_map_longitude) ? $adRecord->ad_map_longitude : '')}}">
                            </section>
                            <section id="ads-phone-section">
                                <h2 class="title">
                                    Telefone
                                </h2>
                                @for($i = 1; $i <= 5; $i++)
                                    <label for="phone[{{$i}}]">Telefone {{$i}}</label>
                                    <input type="text" name="phone[{{$i}}]" value="{{isset($oldInput['phone'][$i]) ? $oldInput['phone'][$i] : (isset($adRecord['adPhoneRecordList']) && $adRecord['adPhoneRecordList']->get($i -1) ? $adRecord['adPhoneRecordList']->get($i -1)->phone_phone : '')}}">
                                @endfor
                            </section>
                            <section id="ads-about-section">
                                <h2 class="title">Sobre</h2>
                                <label for="short_description">Descrição resumida</label>
                                <textarea name="short_description">{{isset($oldInput['short_description']) ? $oldInput['short_description'] : (isset($adRecord->ad_short_description) ? $adRecord->ad_short_description : '')}}</textarea>
                                <label for="description">Descrição</label>
                                <textarea name="description">{{isset($oldInput['description']) ? $oldInput['description'] : (isset($adRecord->ad_description) ? $adRecord->ad_description : '')}}</textarea>
                            </section>
                            <button type="submit" class="btn btn-success">Salvar</button>
                        </form>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
@stop